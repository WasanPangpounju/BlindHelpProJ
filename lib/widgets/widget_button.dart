// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:blindhelp/widgets/widget_text.dart';

class WidgetButton extends StatelessWidget {
  const WidgetButton({
    super.key,
    required this.label,
    required this.pressFunc,
    required this.iconData,
    this.size,
    this.colorIcon,
    this.color,
  });

  final String label;
  final Function() pressFunc;
  final IconData iconData;
  final double? size;
  final Color? colorIcon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // margin: const EdgeInsets.only(top: 8),
      width: size ?? 250, height: 30,
      child: ElevatedButton.icon(
        onPressed: pressFunc,
        icon: Icon(
          iconData,
          size: 20, color: colorIcon,
        ),
        label: WidgetText(
          data: label,
          textStyle: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
