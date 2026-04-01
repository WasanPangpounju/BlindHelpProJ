// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetCircleImage extends StatelessWidget {
  const WidgetCircleImage({
    super.key,
    this.imageProvider,
    this.radius,
  });

  final ImageProvider? imageProvider;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundImage: imageProvider ?? const AssetImage('images/avatar.png'),radius: radius
      ,
    );
  }
}
