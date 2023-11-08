import 'package:blindhelp/utility/app_constant.dart';
import 'package:blindhelp/widgets/widget_text.dart';
import 'package:flutter/material.dart';

class WidgetEditDelete extends StatelessWidget {
  final Function() editFunc;
  final Function() deleteFunc;

  const WidgetEditDelete({
    super.key,
    required this.editFunc,
    required this.deleteFunc,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: editFunc,
          child: Container(
            width: 48,
            padding: const EdgeInsets.all(4),
            decoration: AppConstant().borderBox(bgColor: Colors.blue),
            child:  const Column(
              children: [
                Icon(
                  Icons.edit,color: Colors.white,
                  size: 18,
                ),
                WidgetText(data: 'แก้ไข', textStyle: TextStyle(color: Colors.white),),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        InkWell(
          onTap: deleteFunc,
          child: Container(
            width: 48,
            padding: const EdgeInsets.all(4),
            decoration: AppConstant().borderBox(bgColor: Colors.red.shade700),
            child: const Column(
              children: [
                Icon(
                  Icons.delete,color: Colors.white,
                  size: 18,
                ),
                WidgetText(data: 'ลบ', textStyle: TextStyle(color: Colors.white),),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
