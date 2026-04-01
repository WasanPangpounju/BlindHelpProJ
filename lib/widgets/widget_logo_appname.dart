import 'package:blindhelp/widgets/widget_image_asset.dart';
import 'package:blindhelp/widgets/widget_text.dart';
import 'package:flutter/material.dart';

class WidgetLogoAppName extends StatelessWidget {
  const WidgetLogoAppName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const WidgetImageAsset(
          size: 48,
        ),
        const SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WidgetText(
              data: 'Blind Help',
              textStyle: Theme.of(context).textTheme.titleLarge,
            ),
            // WidgetText(
            //   data: 'ระบบแสดงข้อมูลผู้ป่วยและ อสม.',
            //   textStyle: Theme.of(context).textTheme.bodySmall,
            // )
          ],
        )
      ],
    );
  }
}
