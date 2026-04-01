// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:blindhelp/widgets/widget_text.dart';

class WidgetTitle extends StatelessWidget {
  const WidgetTitle({
    super.key,
    required this.title,
    this.size,
    this.color,
  });

  final String title;
  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return WidgetText(
      data: title,
      textStyle: Theme.of(context)
          .textTheme
          .titleMedium!
          .copyWith(fontWeight: FontWeight.bold, fontSize: size, color: color),
    );
  }
}
