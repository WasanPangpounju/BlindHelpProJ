// ignore_for_file: public_member_api_docs, sort_constructors_first, deprecated_member_use
import 'package:blindhelp/widgets/widget_image_asset.dart';
import 'package:blindhelp/widgets/widget_progress.dart';
import 'package:blindhelp/widgets/widget_text.dart';
import 'package:blindhelp/widgets/widget_text_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppDialog {
  final BuildContext context;
  AppDialog({
    required this.context,
  });

  void progressDialog() {
    Get.dialog(
        WillPopScope(
          child: const WidgetProgress(),
          onWillPop: () async {
            return false;
          },
        ),
        barrierDismissible: false);
  }

  void normalDialog({
    required String tilte,
    Widget? iconWidget,
    Widget? firstAction,
    Widget? secondAction,
    Widget? contentWidget,
  }) {
    Get.dialog(
      AlertDialog(
        icon: iconWidget ??
            const WidgetImageAsset(
              size: 100,
            ),
        title: WidgetText(data: tilte),
        content: contentWidget,
        actions: [
          firstAction ?? const SizedBox(),
          secondAction ?? const SizedBox(),
          WidgetTextButton(
            label: 'Cancel',
            pressFunc: () => Get.back(),
          )
        ],
        scrollable: true,
      ),
      
      barrierDismissible: false,
    );
  }
}
