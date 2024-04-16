import 'package:afeer/utls/extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../manger/color_manger.dart';
import '../manger/font_manger.dart';

class TextFormWidget extends StatefulWidget {
  final String label;
  final bool? isFilled;
  final Color? filledColor;
  final TextEditingController? controller;
  final Widget? suffix;
  final Widget? prefixActive;
  final int? maxLine;
  final bool? active;
  final bool? isObscure;
  final TextStyle? textStyle;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? textInputFormatter;
  final Function(String?)? onSumbted;
  const TextFormWidget(
      {super.key,
      required this.label,
      this.controller,
      this.suffix,
      this.maxLine,
      this.prefixActive,
      this.isFilled,
      this.filledColor,
      this.validator,
      this.active,
      this.onSumbted,
      this.textStyle,
      this.textInputFormatter,
      this.isObscure});

  @override
  State<TextFormWidget> createState() => _TextFormWidgetState();
}

class _TextFormWidgetState extends State<TextFormWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      inputFormatters: widget.textInputFormatter,
      enabled: widget.active,
      obscureText: widget.isObscure ?? false,
      controller: widget.controller,
      maxLines: widget.maxLine ?? 1,
      onFieldSubmitted: widget.onSumbted,
      style: widget.textStyle,
      decoration: InputDecoration(
        suffixIcon: widget.suffix,
        hintText: widget.label,
        filled: true,
        prefixIcon: widget.prefixActive,
        fillColor: widget.filledColor ?? const Color(0xffEFEFEF),
        alignLabelWithHint: true,
        hintStyle: FontsManger.mediumFont(context)
            ?.copyWith(color: const Color(0xff212121).withOpacity(.5)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(width: 1, color: Colors.transparent)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(width: 1, color: Colors.transparent)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(width: 1, color: Colors.transparent)),
        disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(width: 1, color: Colors.transparent)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide:
                BorderSide(width: 1, color: Colors.red.withOpacity(.4))),
      ),
      validator: widget.validator ??
          (value) {
            if (value != null && value.isEmpty) {
              return "من فضلك تاكد من تلك المعلومات ";
            } else {
              return null;
            }
          },
    );
  }
}
