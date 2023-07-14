// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blindhelp/widgets/widget_edit_delete.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                itemBuilder: (context, index) => Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: AppConstant().borderBox(),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WidgetTextRich(
                              title: 'โรค : ',
                              value: appController
                                  .userDiseaseModels[index].disease),
                          WidgetTextRich(
                              title: 'วันเดือนปี ที่บันทึก :',
                              titleColor: AppConstant.bluelive,
                              value: AppService().timeStampToString(
                                  timestamp: appController
                                      .userDiseaseModels[index].timestamp)),
                        ],
                      ),
                      const Spacer(),
                      WidgetEditDelete(
                        editFunc: () {
                          processEdit(index, context);
                        },
                        deleteFunc: () {
                          processDelete(context, index);
                        },
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }

  void processDelete(BuildContext context, int index) {
    AppDialog(context: context).normalDialog(
        tilte: 'ยืนยันลบ โรงประจำตัว',
        firstAction: WidgetButton(
            size: 110,
            label: 'ยืนยัน',
            pressFunc: () {
              AppService()
                  .deleteDisease(
                      docIdDisease: appController.docIdDisease[index])
                  .then((value) {
                AppService().readDisease();
                Get.back();
              });
            },
            iconData: Icons.delete));
  }

  void processEdit(int index, BuildContext context) {
    TextEditingController textEditingController = TextEditingController();
    textEditingController.text = appController.userDiseaseModels[index].disease;
    bool change = false;
    AppDialog(context: context).normalDialog(
        tilte: 'แก้ไข โรคประจำตัว',
        contentWidget: WidgetForm(
          textEditingController: textEditingController,
          changeFunc: (p0) {
            change = true;
          },
        ),
        firstAction: WidgetButton(
            label: 'แก้ไข',
            size: 120,
            pressFunc: () {
              if (change) {
                //edit
                Map<String, dynamic> map =
                    appController.userDiseaseModels[index].toMap();
                map['disease'] = textEditingController.text;
                AppService()
                    .editDisease(
                        docIdDisease: appController.docIdDisease[index],
                        map: map)
                    .then((value) {
                  AppService().readDisease();
                  Get.back();
                });
              } else {
                Get.back();
              }
            },
            iconData: Icons.edit));
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
