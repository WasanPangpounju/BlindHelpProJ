// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blindhelp/utility/app_constant.dart';
import 'package:blindhelp/widgets/widget_text.dart';
import 'package:flutter/material.dart';

class WidgetTextButton extends StatelessWidget {
  const WidgetTextButton({
    super.key,
    required this.label,
    required this.pressFunc,
  });

  final String label;
  final Function() pressFunc;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: pressFunc,
        child: WidgetText(
            data: label,
            textStyle: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: AppConstant.blue, fontSize: 13)));
  }
}
