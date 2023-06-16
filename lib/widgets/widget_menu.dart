// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetMemu extends StatelessWidget {
  const WidgetMemu({
    Key? key,
    required this.leadWidget,
    required this.titleWidget,
    this.tapFunc,
  }) : super(key: key);

  final Widget leadWidget;
  final Widget titleWidget;
  final Function()? tapFunc;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leadWidget,
      title: titleWidget,
      onTap: tapFunc,
    );
  }
}
