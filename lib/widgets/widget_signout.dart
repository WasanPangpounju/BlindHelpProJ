import 'package:blindhelp/utility/app_dialog.dart';
import 'package:blindhelp/widgets/widget_button.dart';
import 'package:blindhelp/widgets/widget_icon_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WidgetSignOut extends StatelessWidget {
  const WidgetSignOut({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WidgetIconButton(
      iconData: Icons.exit_to_app,
      pressFunc: () {
        AppDialog(context: context).normalDialog(
          tilte: 'ยืนยันการ SignOut',
          firstAction: WidgetButton(
            label: 'SignOut',
            pressFunc: () async {
              Get.back();
              FirebaseAuth.instance.signOut().then((value) {
                Get.offAllNamed('/authen');
              });
            },
            iconData: Icons.exit_to_app,
            size: 150,
          ),
        );
      },
    );
  }
}
