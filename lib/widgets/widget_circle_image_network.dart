// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetCircleImageNetwork extends StatelessWidget {
  const WidgetCircleImageNetwork({
    super.key,
    required this.urlImage,
    this.radius,
  });

  final String urlImage;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: NetworkImage(urlImage),
      radius: radius,
    );
  }
}
