// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:blindhelp/utility/app_constant.dart';

class WidgetTextRich extends StatelessWidget {
  const WidgetTextRich({
    super.key,
    required this.title,
    required this.value,
    this.titleColor,
    this.titleStyle,
    this.valueStyle,
  });

  final String title;
  final String value;
  final Color? titleColor;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: title,
        style: titleStyle ?? AppConstant().titleStyle(context: context, color: titleColor, fontSize: 13),
        children: [
          TextSpan(text: value, style: valueStyle ?? Theme.of(context).textTheme.bodyMedium)
        ],
      ),
    );
  }
}
