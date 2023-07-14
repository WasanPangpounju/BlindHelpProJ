// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blindhelp/models/user_model.dart';
import 'package:blindhelp/utility/app_constant.dart';
import 'package:blindhelp/utility/app_controller.dart';
import 'package:blindhelp/utility/app_dialog.dart';
import 'package:blindhelp/utility/app_service.dart';
import 'package:blindhelp/utility/app_snackbar.dart';
import 'package:blindhelp/widgets/widget_button.dart';
import 'package:blindhelp/widgets/widget_form.dart';
import 'package:blindhelp/widgets/widget_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:blindhelp/widgets/widget_image_asset.dart';
import 'package:blindhelp/widgets/widget_text.dart';
import 'package:get/get.dart';

class CreateNewAccount extends StatefulWidget {
  const CreateNewAccount({super.key});

  @override
  State<CreateNewAccount> createState() => _CreateNewAccountState();
}

class _CreateNewAccountState extends State<CreateNewAccount> {
  AppController appController = Get.put(AppController());
  TextEditingController nameController = TextEditingController();
  TextEditingController surNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController alleyWayController = TextEditingController();
  TextEditingController houseNumberController = TextEditingController();
  TextEditingController spcialController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    AppService().readProvince();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: const WidgetImageAsset(
          path: 'images/header.png',
          boxFit: BoxFit.cover,
        ),
        foregroundColor: Colors.white,
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          children: [
            const WidgetTitle(title: 'เลือกประเภทผู้ใช้งาน'),
            typeUserRadio(),
            const WidgetTitle(title: 'ข้อมูลส่วนตัว'),
            nameForm(),
            surnameForm(),
            phoneForm(),
            const WidgetTitle(title: 'ข้อมูลสำหรับลงชื่อเข้าใช้งาน'),
            emailForm(),
            passwordForm(),
            const WidgetTitle(title: 'ที่อยู่ผู้สมัคร'),
            proviceDropdown(),
            amphurDropdown(),
            districZipGroup(),
            Obx(() {
              return appController.chooseDistriceModels.last == null
                  ? const SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 16,
                        ),
                        WidgetTitle(title: appController.typeUser.value),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            WidgetForm(
                              labelWidget: WidgetText(
                                  data: appController.typeUser.value ==
                                          AppConstant.typeUsers[0]
                                      ? 'โรงพยาบาลที่รักษาประจำ'
                                      : 'พื้นที่ดูแล'),
                              textEditingController: spcialController,
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: appController.accept.value,
                              onChanged: (value) {
                                appController.accept.value = value!;
                              },
                            ),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  width: 250,
                                  child: WidgetText(
                                    data:
                                        'การคลิกปุ่มนี้เพื่อใช้บริการ หมายความว่า ข้าพเจ้าตกลงให้ blind help มีสิทธิ์รวบรวม ใช้ และเปิดเผยข้อมูลที่ข้าพเจ้าเตรียมให้โดยเป็นไปตาม ประกาศความเป็นส่วนตัว และข้าพเจ้าตกลงปฏิบัติตาม ข้อกำหนดและเงื่อนไขในการใช้บริการ ซึ่งข้าพเจ้าได้อ่านและทำความเข้าใจเรียบร้อยแล้ว',
                                    textStyle:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            WidgetButton(
                                label: 'ลงทะเบียน',
                                pressFunc: () async {
                                  if (nameController.text.isEmpty) {
                                    AppSnackBar(
                                            context: context,
                                            title: 'ชื่อจริง ?',
                                            message: 'โปรดกรอกชื่อจริง ด้วยคะ')
                                        .errorSnackBar();
                                  } else if (surNameController.text.isEmpty) {
                                    AppSnackBar(
                                            context: context,
                                            title: 'นามสกุล ?',
                                            message: 'โปรดกรอกนามสกุล ด้วยคะ')
                                        .errorSnackBar();
                                  } else if (phoneController.text.isEmpty) {
                                    AppSnackBar(
                                            context: context,
                                            title: 'เบอร์ติดต่อ ?',
                                            message:
                                                'โปรดกรอกเบอร์ติดต่อ ด้วยคะ')
                                        .errorSnackBar();
                                  } else if (emailController.text.isEmpty) {
                                    AppSnackBar(
                                            context: context,
                                            title: 'อีเมล ?',
                                            message: 'โปรดกรอกอีเมล ด้วยคะ')
                                        .errorSnackBar();
                                  } else if (passwordController.text.isEmpty) {
                                    AppSnackBar(
                                            context: context,
                                            title: 'Password ?',
                                            message: 'โปรดกรอก Password ด้วยคะ')
                                        .errorSnackBar();
                                  } else if (alleyWayController.text.isEmpty) {
                                    AppSnackBar(
                                            context: context,
                                            title: 'หมู่บ้าน หรือ ซอย ?',
                                            message:
                                                'โปรดกรอกหมู่บ้าน หรือ ซอย ด้วยคะ')
                                        .errorSnackBar();
                                  } else if (houseNumberController
                                      .text.isEmpty) {
                                    AppSnackBar(
                                            context: context,
                                            title: 'บ้านเลขที่ ?',
                                            message:
                                                'โปรดกรอกบ้านเลขที่ ด้วยคะ')
                                        .errorSnackBar();
                                  } else if (spcialController.text.isEmpty) {
                                    if (appController.typeUser.value ==
                                        AppConstant.typeUsers[0]) {
                                      AppSnackBar(
                                              context: context,
                                              title: 'โรงพยาบาลที่รักษาประจำ ?',
                                              message:
                                                  'โปรดกรอก โรงพยาบาลที่รักษาประจำ ด้วยคะ')
                                          .errorSnackBar();
                                    } else {
                                      AppSnackBar(
                                              context: context,
                                              title: 'พื้นที่ดูแล ?',
                                              message:
                                                  'โปรดกรอก พื้นที่ดูแล ด้วยคะ')
                                          .errorSnackBar();
                                    }
                                  } else if (!appController.accept.value) {
                                    AppSnackBar(
                                            context: context,
                                            title: 'ข้อกำหนด และ เงื่อนไข ?',
                                            message:
                                                'โปรดยืนยัน ข้อกำหนด และ เงื่อนไข ด้วยคะ')
                                        .errorSnackBar();
                                  } else {
                                    AppDialog(context: context)
                                        .progressDialog();
                                    await FirebaseAuth.instance
                                        .createUserWithEmailAndPassword(
                                            email: emailController.text,
                                            password: passwordController.text)
                                        .then((value) async {
                                      String uid = value.user!.uid;
                                      UserModel userModel = UserModel(
                                          uid: uid,
                                          typeUser:
                                              appController.typeUser.value,
                                          name: nameController.text,
                                          surName: surNameController.text,
                                          phone: phoneController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          province: appController
                                              .chooseProviceModels
                                              .last!
                                              .name_th,
                                          amphur: appController
                                              .chooseAmphurModels.last!.name_th,
                                          districe: appController
                                              .chooseDistriceModels
                                              .last!
                                              .name_th,
                                          zipCode: appController
                                              .chooseDistriceModels
                                              .last!
                                              .zip_code,
                                          alleyWay: alleyWayController.text,
                                          houseNumber:
                                              houseNumberController.text,
                                          spcial: spcialController.text,
                                          timestamp: Timestamp.fromDate(
                                              DateTime.now()));

                                      await FirebaseFirestore.instance
                                          .collection('user')
                                          .doc(uid)
                                          .set(userModel.toMap())
                                          .then((value) {
                                        Get.back();
                                        Get.back();
                                        AppSnackBar(
                                                context: context,
                                                title: 'ลงทะเบียนสำเร็จ',
                                                message:
                                                    'ลงชื่อเข้าใช้งานได้เลย คะ')
                                            .normalSnackBar();
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
                                iconData: Icons.person),
                          ],
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                      ],
                    );
            })
          ],
        ),
      ),
    );
  }

  Obx districZipGroup() {
    return Obx(() {
      return appController.chooseAmphurModels.last == null
          ? const SizedBox()
          : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: AppConstant().borderBox(),
                      width: 250,
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      margin: const EdgeInsets.only(top: 16),
                      child: DropdownButton(
                        isExpanded: true,
                        underline: const SizedBox(),
                        items: appController.districeNameThModels
                            .map(
                              (element) => DropdownMenuItem(
                                // ignore: sort_child_properties_last
                                child: WidgetText(data: element.name_th),
                                value: element,
                              ),
                            )
                            .toList(),
                        value: appController.chooseDistriceModels.last,
                        hint: const WidgetText(data: 'แขวง/ตำบล'),
                        onChanged: (value) {
                          appController.chooseDistriceModels.add(value);
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 250,
                  height: 40,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 8),
                  margin: const EdgeInsets.only(top: 16),
                  decoration: AppConstant().borderBox(),
                  child: WidgetText(
                      data: appController.chooseDistriceModels.last?.zip_code ??
                          ''),
                ),
                WidgetForm(
                  labelWidget: const WidgetText(data: 'หมู่/ซอย'),
                  textEditingController: alleyWayController,
                ),
                WidgetForm(
                  labelWidget: const WidgetText(data: 'บ้านเลขที่'),
                  textEditingController: houseNumberController,
                  textInputType: TextInputType.text,
                ),
              ],
            );
    });
  }

  Obx amphurDropdown() {
    return Obx(() {
      return appController.amphurNameThModels.isEmpty
          ? const SizedBox()
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: AppConstant().borderBox(),
                  width: 250,
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  margin: const EdgeInsets.only(top: 16),
                  child: DropdownButton(
                    underline: const SizedBox(),
                    isExpanded: true,
                    items: appController.amphurNameThModels
                        .map(
                          (element) => DropdownMenuItem(
                            // ignore: sort_child_properties_last
                            child: WidgetText(data: element.name_th),
                            value: element,
                          ),
                        )
                        .toList(),
                    value: appController.chooseAmphurModels.last,
                    hint: const WidgetText(data: 'เขต/อำเภอ'),
                    onChanged: (value) {
                      appController.chooseAmphurModels.add(value);
                      AppService().readDistrice(idAmphur: value!.id);
                    },
                  ),
                ),
              ],
            );
    });
  }

  Row proviceDropdown() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: AppConstant().borderBox(),
          width: 250,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          margin: const EdgeInsets.only(top: 16),
          child: Obx(() {
            return appController.provinceNameThModels.isEmpty
                ? const SizedBox()
                : DropdownButton(
                    isExpanded: true,
                    underline: const SizedBox(),
                    items: appController.provinceNameThModels
                        .map(
                          (element) => DropdownMenuItem(
                            // ignore: sort_child_properties_last
                            child: WidgetText(data: element.name_th),
                            value: element,
                          ),
                        )
                        .toList(),
                    value: appController.chooseProviceModels.last,
                    hint: const WidgetText(data: 'จังหวัด | Province'),
                    onChanged: (value) {
                      appController.chooseProviceModels.add(value);
                      AppService().readAmphur(idProvince: value!.id);
                    },
                  );
          }),
        ),
      ],
    );
  }

  Row phoneForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WidgetForm(
          labelWidget: const WidgetText(data: 'เบอร์โทรติดต่อ'),
          marginBottom: 16,
          textEditingController: phoneController,
          textInputType: TextInputType.phone,
        ),
      ],
    );
  }

  Row surnameForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WidgetForm(
          labelWidget: const WidgetText(data: 'นามสกุล'),
          textEditingController: surNameController,
        ),
      ],
    );
  }

  Row nameForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WidgetForm(
          labelWidget: const WidgetText(data: 'ชื่อจริง'),
          textEditingController: nameController,
        ),
      ],
    );
  }

  Row emailForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WidgetForm(
          labelWidget: const WidgetText(data: 'อีเมล'),
          textEditingController: emailController,
          textInputType: TextInputType.emailAddress,
        ),
      ],
    );
  }

  Row passwordForm() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WidgetForm(
          labelWidget: const WidgetText(data: 'รหัสผ่านหรือพาสเวิร์ด'),
          marginBottom: 16,
          textEditingController: passwordController,
        ),
      ],
    );
  }

  Obx typeUserRadio() {
    return Obx(() => Column(
          children: [
            RadioListTile(
              value: AppConstant.typeUsers[0],
              groupValue: appController.typeUser.value,
              onChanged: (value) {
                appController.typeUser.value = value.toString();
              },
              title: WidgetText(data: AppConstant.typeUsers[0]),
            ),
            RadioListTile(
              value: AppConstant.typeUsers[1],
              groupValue: appController.typeUser.value,
              onChanged: (value) {
                appController.typeUser.value = value.toString();
              },
              title: WidgetText(data: AppConstant.typeUsers[1]),
            )
          ],
        ));
  }
}
