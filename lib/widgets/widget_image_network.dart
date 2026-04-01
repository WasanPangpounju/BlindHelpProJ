// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blindhelp/utility/app_constant.dart';
import 'package:blindhelp/widgets/widget_text.dart';
import 'package:flutter/material.dart';

class WidgetImageNewwork extends StatelessWidget {
  const WidgetImageNewwork({
    super.key,
    required this.url,
    this.boxFit,
    this.width,
    this.height,
  });

  final String url;
  final BoxFit? boxFit;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      fit: boxFit,
      width: width,
      height: height,
      errorBuilder: (context, error, stackTrace) => Container(
        decoration: AppConstant().curveBox(context: context),
        width: 150,
        height: 150,
        alignment: Alignment.center,
        child: const WidgetText(data: 'ไม่มีรูปภาพ'),
      ),
    );
  }
}
