// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blindhelp/widgets/widget_image_network.dart';
import 'package:blindhelp/widgets/widget_text.dart';
import 'package:blindhelp/widgets/widget_title.dart';
import 'package:flutter/material.dart';

import 'package:blindhelp/models/article_model.dart';

class DisplayArticle extends StatelessWidget {
  const DisplayArticle({
    super.key,
    required this.articleModel,
  });

  final ArticleModel articleModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const WidgetText(data: 'บทความสุขภาพ'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          WidgetTitle(title: articleModel.title),
          articleModel.urlImage.isEmpty
              ? const SizedBox()
              : WidgetImageNewwork(url: articleModel.urlImage),
          const WidgetTitle(title: 'เนื้อหา'),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16),
            padding: const EdgeInsets.all(8),
            // decoration: AppConstant().borderBox(),
            child: WidgetTitle(title: articleModel.article),
          ),
        ],
      ),
    );
  }
}
