import 'package:blindhelp/states/display_article.dart';
import 'package:blindhelp/utility/app_controller.dart';
import 'package:blindhelp/utility/app_service.dart';
import 'package:blindhelp/widgets/widget_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReadArticle extends StatefulWidget {
  const ReadArticle({super.key});

  @override
  State<ReadArticle> createState() => _ReadArticleState();
}

class _ReadArticleState extends State<ReadArticle> {
  @override
  void initState() {
    super.initState();
    AppService().readAllArticle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const WidgetText(data: 'บทความสุขภาพ'),
      // ),
      body: GetX(
        init: AppController(),
        builder: (controller) => controller.articleModels.isEmpty
            ? const SizedBox()
            : ListView.builder(
                itemCount: controller.articleModels.length,
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Get.to(DisplayArticle(
                        articleModel: controller.articleModels[index]));
                  },
                  child: Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    padding: const EdgeInsets.all(8),
                    // decoration: AppConstant().borderBox(),
                    child:
                        WidgetText(data: controller.articleModels[index].title),
                  ),
                ),
              ),
      ),
    );
  }
}
