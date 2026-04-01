// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class WidgetForm extends StatelessWidget {
  const WidgetForm({
    super.key,
    this.hint,
    this.prefixWidget,
    this.subfixWidget,
    this.textEditingController,
    this.labelWidget,
    this.marginBottom,
    this.marginTop,
    this.textInputType,
    this.obsecu,
    this.width,
    this.changeFunc,
    this.maxLine,
  });

  final String? hint;
  final Widget? prefixWidget;
  final Widget? subfixWidget;
  final TextEditingController? textEditingController;
  final Widget? labelWidget;
  final double? marginBottom;
  final double? marginTop;
  final TextInputType? textInputType;
  final bool? obsecu;
  final double? width;
  final Function(String)? changeFunc;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 250,
      height: maxLine == null ?  40 : null,
      margin:
          EdgeInsets.only(top: marginTop ?? 16, bottom: marginBottom ?? 0.0),
      child: TextFormField(maxLines: maxLine ?? 1,
        onChanged: changeFunc,
        controller: textEditingController,
        obscureText: obsecu ?? false,
        keyboardType: textInputType,
        decoration: InputDecoration(
          label: labelWidget,
          hintText: hint,
          prefixIcon: prefixWidget,
          suffixIcon: subfixWidget,
          filled: true,
          border: const OutlineInputBorder(),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        ),
      ),
    );
  }
}
