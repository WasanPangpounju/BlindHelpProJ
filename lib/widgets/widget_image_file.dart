// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';

class WidgetImageFile extends StatelessWidget {
  const WidgetImageFile({
    super.key,
    required this.file,
    this.size,
    this.boxFit,
  });

  final File file;
  final double? size;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return Image.file(
      file,
      width: size,
      height: size,
      fit: boxFit,
    );
  }
}
