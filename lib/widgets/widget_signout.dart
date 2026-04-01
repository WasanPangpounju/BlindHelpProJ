import 'package:blindhelp/utility/app_constant.dart';
import 'package:blindhelp/utility/app_dialog.dart';
import 'package:blindhelp/widgets/widget_menu.dart';
import 'package:blindhelp/widgets/widget_text.dart';
import 'package:blindhelp/widgets/widget_text_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WidgetSignOut extends StatelessWidget {
  const WidgetSignOut({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.red.shade700),
      child: WidgetMemu(
        leadWidget: const Icon(
          Icons.exit_to_app,
          color: Colors.white,
        ),
        titleWidget: WidgetText(
          data: 'ออกจากระบบ',
          textStyle:
              AppConstant().titleStyle(context: context, color: Colors.white),
        ),
        tapFunc: () {
          Get.back();
          AppDialog(context: context).normalDialog(
            tilte: 'ยืนยันการ SignOut',
            firstAction: WidgetTextButton(
              label: 'SignOut',
              pressFunc: () async {
                Get.back();
                FirebaseAuth.instance.signOut().then((value) async {
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  preferences.clear().then((value) {
                    Get.offAllNamed('/authen');
                  });
                });
              },
              // iconData: Icons.exit_to_app,
              // size: 130,
            ),
          );
        },
      ),
    );
  }
}
