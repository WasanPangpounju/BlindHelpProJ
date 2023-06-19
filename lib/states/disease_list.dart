import 'package:blindhelp/models/disease_model.dart';
import 'package:blindhelp/utility/app_constant.dart';
import 'package:blindhelp/utility/app_controller.dart';
import 'package:blindhelp/utility/app_dialog.dart';
import 'package:blindhelp/utility/app_service.dart';
import 'package:blindhelp/utility/app_snackbar.dart';
import 'package:blindhelp/widgets/widget_button.dart';
import 'package:blindhelp/widgets/widget_form.dart';
import 'package:blindhelp/widgets/widget_text.dart';
import 'package:blindhelp/widgets/widget_text_rich.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiseaseList extends StatefulWidget {
  const DiseaseList({super.key});

  @override
  State<DiseaseList> createState() => _DiseaseListState();
}

class _DiseaseListState extends State<DiseaseList> {
  AppController appController = Get.put(AppController());

  @override
  void initState() {
    super.initState();
    AppService().readDisease();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const WidgetText(data: 'โรคประจำตัว :'),
      ),
      floatingActionButton: displayFloating(context),
      body: Obx(() {
        return appController.userDiseaseModels.isEmpty
            ? const SizedBox()
            : ListView.builder(
                itemCount: appController.userDiseaseModels.length,
                itemBuilder: (context, index) => Container(padding: const EdgeInsets.all(8),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: AppConstant().borderBox(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      WidgetTextRich(
                          title: 'โรคประจำตัว :',
                          value:
                              appController.userDiseaseModels[index].disease),
                      WidgetTextRich(
                          title: 'วันเดือนปี ที่บันทึก :',
                          titleColor: AppConstant.bluelive,
                          value: AppService().timeStampToString(
                              timestamp: appController
                                  .userDiseaseModels[index].timestamp)),
                    ],
                  ),
                ),
              );
      }),
    );
  }

  WidgetButton displayFloating(BuildContext context) {
    return WidgetButton(
        label: 'เพิ่ม โรคประจำตัว',
        pressFunc: () {
          String? string;
          AppDialog(context: context).normalDialog(
              tilte: 'เพิ่ม โรคประจำตัว',
              contentWidget: WidgetForm(
                labelWidget: const WidgetText(data: 'โรคประจำตัว'),
                changeFunc: (p0) {
                  string = p0.trim();
                },
              ),
              firstAction: WidgetButton(
                label: 'เพิ่ม',
                pressFunc: () {
                  if (string?.isEmpty ?? true) {
                    AppSnackBar(
                            context: context,
                            title: 'ยังไม่ได้ใส่ โรคประจำตัว',
                            message: 'โปรดกรอก โรคประจำตัว ด้วยคะ')
                        .errorSnackBar();
                  } else {
                    DiseaseModel diseaseModel = DiseaseModel(
                        disease: string!,
                        timestamp: Timestamp.fromDate(DateTime.now()));
                    AppService()
                        .addDisease(diseaseModel: diseaseModel)
                        .then((value) {
                      Get.back();
                      AppService().readDisease();
                      AppSnackBar(
                              context: context,
                              title: 'เพิ่มโรคประจำตัว สำเร็จ',
                              message: 'เพิ่มโรค $string สำเร็จ')
                          .normalSnackBar();
                    });
                  }
                },
                iconData: Icons.add_box,
                size: 100,
              ));
        },
        size: 190,
        iconData: Icons.add_box);
  }
}
