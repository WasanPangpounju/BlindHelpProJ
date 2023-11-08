// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetImageAsset extends StatelessWidget {
  const WidgetImageAsset({
    super.key,
    this.size,
    this.path,
    this.boxFit,
  });

  final double? size;
  final String? path;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path ?? 'images/mainlogo.png',
      width: size,
      height: size,fit: boxFit,
    );
  }
}
