// ignore_for_file: avoid_print

import 'package:blindhelp/states/display_result_qr_scan.dart';
import 'package:blindhelp/utility/app_constant.dart';
import 'package:blindhelp/widgets/widget_icon_button.dart';
import 'package:blindhelp/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScanPage extends StatefulWidget {
  const QrScanPage({super.key});

  @override
  State<QrScanPage> createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  final MobileScannerController scanController = MobileScannerController();
  bool hasNavigated = false;

  @override
  void dispose() {
    scanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            MobileScanner(
              controller: scanController,
              onDetect: (capture) {
                if (hasNavigated) {
                  return;
                }
                final String? data = capture.barcodes.isNotEmpty
                    ? capture.barcodes.first.rawValue
                    : null;
                if (data == null || data.isEmpty) {
                  return;
                }
                hasNavigated = true;
                print('##28oct value scan ----> $data');
                Get.off(DisplayResultQRscan(resultQR: data));
              },
            ),
            Positioned(
              right: 16,
              top: 16,
              child: Column(mainAxisSize: MainAxisSize.min,
                children: [
                  WidgetIconButton(
                    iconData: Icons.flash_on,
                    pressFunc: () {
                      scanController.toggleTorch();
                    },
                    size: 36,
                    color: Colors.white,
                  ),
                   WidgetText(
                    data: 'เปิดแฟลซ',
                    textStyle: AppConstant()
                        .titleStyle(context: context, color: Colors.white),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 16,
              top: 16,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  WidgetIconButton(
                    iconData: Icons.clear,
                    pressFunc: () {
                      Get.back();
                    },
                    size: 36,
                    color: Colors.white,
                  ),
                  WidgetText(
                    data: 'ปิด',
                    textStyle: AppConstant()
                        .titleStyle(context: context, color: Colors.white),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 16,
              bottom: 16,
              child: Column(mainAxisSize: MainAxisSize.min,
                children: [
                  WidgetIconButton(
                    iconData: Icons.photo_library,
                    pressFunc: () async {
                      var result = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (result != null) {
                        final BarcodeCapture? capture =
                            await scanController.analyzeImage(result.path);
                        final String? value = capture != null &&
                                capture.barcodes.isNotEmpty
                            ? capture.barcodes.first.rawValue
                            : null;
                        print('##30oct value scan ---> $value');
                        if (value != null && value.isNotEmpty) {
                          Get.off(DisplayResultQRscan(resultQR: value));
                        }
                      }
                    },
                    size: 36,
                    color: Colors.white,
                  ),
                   WidgetText(
                    data: 'สแกนจากภาพ',
                    textStyle: AppConstant()
                        .titleStyle(context: context, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
