// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blindhelp/widgets/widget_image_network.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'package:blindhelp/models/article_model.dart';
import 'package:blindhelp/utility/app_constant.dart';
import 'package:blindhelp/utility/app_controller.dart';
import 'package:blindhelp/utility/app_service.dart';
import 'package:blindhelp/utility/app_snackbar.dart';
import 'package:blindhelp/widgets/widget_button.dart';
import 'package:blindhelp/widgets/widget_form.dart';
import 'package:blindhelp/widgets/widget_image_file.dart';
import 'package:blindhelp/widgets/widget_text.dart';

class EditArticle extends StatefulWidget {
  const EditArticle({
    super.key,
    required this.articleModel,
    required this.docIdArticle,
  });

  final ArticleModel articleModel;
  final String docIdArticle;

  @override
  State<EditArticle> createState() => _EditArticleState();
}

class _EditArticleState extends State<EditArticle> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController titleTextEditingController = TextEditingController();

  AppController appController = Get.find<AppController>();
  bool change = false;

  @override
  void initState() {
    super.initState();
    textEditingController.text = widget.articleModel.article;
    titleTextEditingController.text = widget.articleModel.title;

    if (appController.files.isNotEmpty) {
      appController.files.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const WidgetText(data: 'แก้ไขบทความ'),
      ),
      body: LayoutBuilder(builder: (context, BoxConstraints boxConstraints) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            height: boxConstraints.maxHeight,
            child: ListView(
              children: [
                WidgetForm(
                  labelWidget: const WidgetText(data: 'ชื่อบทความ/ข่าวสาร'),
                  textEditingController: titleTextEditingController,
                  changeFunc: (p0) {
                    change = true;
                  },
                ),
                const SizedBox(height: 16),
                WidgetText(
                  data: 'พิมข้อความของคุณ',
                  textStyle: AppConstant().titleStyle(context: context),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: boxConstraints.maxHeight * 0.35,
                  child: TextFormField(
                    controller: textEditingController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 20,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                    ),
                    onChanged: (value) {
                      change = true;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    children: [
                      WidgetButton(
                          label: 'อัพโหลดรูปภาพ',
                          pressFunc: () {
                            AppService()
                                .takePhoto(imageSource: ImageSource.gallery)
                                .then((value) {
                              change = true;
                            });
                          },
                          iconData: Icons.image),
                    ],
                  ),
                ),
                Obx(() {
                  return appController.files.isEmpty
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            WidgetImageNewwork(
                              url: widget.articleModel.urlImage,
                              width: 150,
                              height: 150,
                              boxFit: BoxFit.cover,
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            WidgetImageFile(
                              file: appController.files.last,
                              size: 150,
                              boxFit: BoxFit.cover,
                            ),
                          ],
                        );
                }),
                const SizedBox(
                  height: 64,
                ),
              ],
            ),
          ),
        );
      }),
      floatingActionButton: WidgetButton(
          label: 'บันทึกบทความ',
          pressFunc: () async {
            if (!change) {
              AppSnackBar(
                      context: context,
                      title: 'ยังไม่มีการเปลี่ยนแปลง อะไร ? เลย',
                      message: 'กรุณาพิมพ์ บทความ หรือ เปลี่ยนรูป ก่อนคะ')
                  .errorSnackBar();
            } else {
              Map<String, dynamic> map = widget.articleModel.toMap();
              map['title'] = titleTextEditingController.text;
              map['article'] = textEditingController.text;

              if (appController.files.isNotEmpty) {
                String? urlImage =
                    await AppService().uploadImage(path: 'article');
                map['urlImage'] = urlImage;
              }

              AppService()
                  .processEditArticle(
                      map: map, docIdArticle: widget.docIdArticle)
                  .then((value) => Get.back());
            }
          },
          iconData: Icons.save),
    );
  }
}
