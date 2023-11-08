// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:blindhelp/widgets/widget_text.dart';

class WidgetButtonOutline extends StatelessWidget {
  const WidgetButtonOutline({
    super.key,
    required this.label,
    required this.pressFunc,
    required this.iconData,
  });

  final String label;
  final Function() pressFunc;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      width: 250,
      height: 30,
      child: OutlinedButton.icon(
        onPressed: pressFunc,
        icon: Icon(
          iconData,
          size: 20,
        ),
        label: WidgetText(
          data: label,
          textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w500),
        ),
        style: ElevatedButton.styleFrom(
          // backgroundColor: Theme.of(context).primaryColor,
          // foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
