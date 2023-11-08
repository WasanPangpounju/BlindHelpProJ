// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'package:blindhelp/widgets/widget_button.dart';
import 'package:blindhelp/widgets/widget_two_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:blindhelp/utility/app_constant.dart';
import 'package:blindhelp/utility/app_controller.dart';
import 'package:blindhelp/utility/app_service.dart';
import 'package:blindhelp/widgets/widget_progress.dart';
import 'package:blindhelp/widgets/widget_text.dart';

class DisplayResultQRscan extends StatefulWidget {
  const DisplayResultQRscan({
    super.key,
    required this.resultQR,
  });

  final String resultQR;

  @override
  State<DisplayResultQRscan> createState() => _DisplayResultQRscanState();
}

class _DisplayResultQRscanState extends State<DisplayResultQRscan> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    appController.load.value = true;

    AppService().readQrFromResult(resultQr: widget.resultQR);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(child: Obx(() {
        print('##8nov qrModel ---> ${appController.qrModels.last.toMap()}');
        return appController.load.value
            ? const WidgetProgress()
            : appController.qrModels.isEmpty
                ? Center(
                    child: WidgetText(
                      data: 'ไม่มีข้อมูล',
                      textStyle: AppConstant().titleStyle(context: context),
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    children: [
                      WidgetTwoText(
                        head: 'ชื่อสถานพยาบาล',
                        value: appController.qrModels.last.nameDrug,
                      ),
                      WidgetTwoText(
                        head: 'เลขที่ประจำตัว ผู้ป่วย (HN)',
                        value: appController.qrModels.last.Hn,
                      ),
                      WidgetTwoText(
                        head: 'ชื่อยา ชื่อสามัญทางยา',
                        value: appController.qrModels.last.nameDrug,
                      ),
                      WidgetTwoText(
                        head: 'รูปแบบของยา ความแรงของยา',
                        value: appController.qrModels.last.detailDrug,
                      ),
                      WidgetTwoText(
                        head: 'วิธีการใช้ยา',
                        value: appController.qrModels.last.howtoDrug,
                      ),
                      WidgetTwoText(
                        head: 'สรรพคุณของยา ',
                        value: appController.qrModels.last.properiesDrug,
                      ),
                      WidgetTwoText(
                        head: 'คำเตือน หรือข้อควรระวัง ',
                        value: appController.qrModels.last.warnningDrug,
                      ),
                      WidgetTwoText(
                        head: 'วันหมดอายุของยา',
                        value: appController.qrModels.last.expireDate
                            .toDate()
                            .toString(),
                      ),
                      WidgetTwoText(
                        head: 'หมายเหตุสำหรับคนพิการ',
                        value: appController.qrModels.last.remark,
                      ),
                    ],
                  );
      })),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              WidgetButton(
                label: 'บันทึก',
                pressFunc: () {},
                iconData: Icons.save,
                size: 150,
              ),
              WidgetButton(
                label: 'ปิด',
                pressFunc: () {
                  Get.back();
                },
                iconData: Icons.close,
                size: 150,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
