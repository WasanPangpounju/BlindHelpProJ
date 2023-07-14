import 'package:flutter/material.dart';

class AppConstant {
  static Color bluelive = const Color.fromARGB(255, 78, 146, 236);
  static Color blue = const Color.fromARGB(255, 120, 159, 237);
  static Color blueDark = const Color(0xff1257E5);

  static final List<String> typeUsers = <String>[
    'คนพิการทางการมองเห็น',
    'อาสาสมัครสาธารณะสุขประจำหมู่บ้าน(อสม.)',
  ];

  TextStyle titleStyle({required BuildContext context, Color? color, double? fontSize}) =>
      Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: fontSize,
          color: color ?? Theme.of(context).primaryColor,
          fontWeight: FontWeight.w700);

  BoxDecoration borderBox({Color? bgColor}) => BoxDecoration(
      border: Border.all(), borderRadius: BorderRadius.circular(4), color: bgColor);

  BoxDecoration gradientBox({required BuildContext context}) => BoxDecoration(
      gradient: RadialGradient(
          colors: <Color>[Colors.white, Theme.of(context).primaryColor],
          center: Alignment.topLeft,
          radius: 1.3));

  BoxDecoration curveBox({required BuildContext context, double? radius}) =>
      BoxDecoration(color: AppConstant.blue, borderRadius: BorderRadius.circular(radius ?? 10));
}
