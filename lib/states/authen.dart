import 'package:blindhelp/models/user_model.dart';
import 'package:blindhelp/states/create_new_account.dart';
import 'package:blindhelp/utility/app_constant.dart';
import 'package:blindhelp/utility/app_controller.dart';
import 'package:blindhelp/utility/app_dialog.dart';
import 'package:blindhelp/utility/app_snackbar.dart';
import 'package:blindhelp/widgets/widget_button.dart';
import 'package:blindhelp/widgets/widget_button_outline.dart';
import 'package:blindhelp/widgets/widget_form.dart';
import 'package:blindhelp/widgets/widget_logo_appname.dart';
import 'package:blindhelp/widgets/widget_text.dart';
import 'package:blindhelp/widgets/widget_text_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authen extends StatefulWidget {
  const Authen({super.key});

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  AppController appController = Get.put(AppController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ListView(
          children: [
            showHeader(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WidgetForm(
                  hint: 'ชื่อผู้ใช้หรืออีเมล',
                  prefixWidget: const Icon(Icons.person_3_outlined),
                  textEditingController: emailController,
                  textInputType: TextInputType.emailAddress,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WidgetForm(
                  hint: 'รหัสผ่านหรือพาสเวิร์ด',
                  prefixWidget: const Icon(Icons.lock_outline),
                  textEditingController: passwordController,
                  obsecu: true,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  child: Obx(() {
                    return CheckboxListTile(
                      value: appController.remember.value,
                      onChanged: (value) {
                        appController.remember.value = value!;
                      },
                      title: WidgetText(
                        data: 'จดจำฉันไว้',
                        textStyle: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      secondary: WidgetTextButton(
                        label: 'ลืมรหัสผ่าน?',
                        pressFunc: () {},
                      ),
                    );
                  }),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WidgetButton(
                  label: 'เข้าสู่ระบบ',
                  pressFunc: () async {
                    if (emailController.text.isEmpty) {
                      AppSnackBar(
                              context: context,
                              title: 'ชื่อผู้ใช้หรืออีเมล ?',
                              message: 'โปรดกรอก ชื่อผู้ใช้หรืออีเมล ด้วยคะ')
                          .errorSnackBar();
                    } else if (passwordController.text.isEmpty) {
                      AppSnackBar(
                              context: context,
                              title: 'รหัสผ่านหรือพาสเวิร์ด',
                              message: 'โปรดกรอก รหัสผ่านหรือพาสเวิร์ด ด้วยคะ')
                          .errorSnackBar();
                    } else {
                      AppDialog(context: context).progressDialog();

                      await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text)
                          .then((value) async {
                        String uid = value.user!.uid;
                        appController.uidLogin.value = uid;
                        await FirebaseFirestore.instance
                            .collection('user')
                            .doc(uid)
                            .get()
                            .then((value) async {
                              
                          if (appController.remember.value) {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            preferences.setBool('remember', true);
                          }

                          Get.back();
                          UserModel userModel =
                              UserModel.fromMap(value.data()!);
                          appController.userModelLogins.add(userModel);
                          if (userModel.typeUser == AppConstant.typeUsers[0]) {
                            Get.offAllNamed('/user');
                          } else if (userModel.typeUser ==
                              AppConstant.typeUsers[1]) {
                            Get.offAllNamed('/helper');
                          } else {
                            // ignore: use_build_context_synchronously
                            AppSnackBar(
                                context: context,
                                title: 'Have Proble',
                                message: 'Please Restart');
                          }
                        });
                      }).catchError((onError) {
                        Get.back();
                        AppSnackBar(
                                context: context,
                                title: onError.code,
                                message: onError.message)
                            .errorSnackBar();
                      });
                    }
                  },
                  iconData: Icons.person_3_outlined,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WidgetButtonOutline(
                  label: 'ลงทะเบียน',
                  pressFunc: () {
                    Get.to(const CreateNewAccount());
                  },
                  iconData: Icons.person_3_outlined,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row showHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 100),
          width: 250,
          child: const WidgetLogoAppName(),
        ),
      ],
    );
  }
}
