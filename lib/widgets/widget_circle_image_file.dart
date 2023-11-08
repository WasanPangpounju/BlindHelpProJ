// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';

class WidgetCircleImageFile extends StatelessWidget {
  const WidgetCircleImageFile({
    super.key,
    required this.file,
    required this.radius,
  });

  final File file;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: FileImage(file),radius: radius,
    );
  }
}
