
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
  final bool? active;
  final TextStyle? textStyle;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? textInputFormatter;
  final  Function(String?)? onSumbted;
  const TextFormWidget({super.key, required this.label, this.controller,  this.suffix, this.prefixActive, this.isFilled, this.filledColor, this.validator, this.active, this.onSumbted, this.textStyle, this.textInputFormatter});

  @override
  State<TextFormWidget> createState() => _TextFormWidgetState();
}

class _TextFormWidgetState extends State<TextFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: context.width,
      height: 43,
      decoration: BoxDecoration(
        color:widget.filledColor?? Colors.white,
borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1,color: const Color(0xff707070))
      ),
      child: TextFormField(
textAlignVertical: TextAlignVertical.center,
        inputFormatters: widget.textInputFormatter,
        enabled: widget.active,
        controller:widget.controller,
        onFieldSubmitted: widget.onSumbted,
        style:widget.textStyle,
        decoration: InputDecoration(
          prefix: widget.prefixActive,
          suffixIcon:widget.suffix,
          hintText:widget.label,
          filled: true,
          fillColor: widget.filledColor??Colors.white,
          alignLabelWithHint: true,
          hintStyle:FontsManger.mediumFont(context)?.copyWith(color: ColorsManger.text3.withOpacity(.20)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: const BorderSide(width:1,color: Colors.transparent)),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: const BorderSide(width:1,color: Colors.transparent)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: const BorderSide(width:1,color: Colors.transparent)),
          disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: const BorderSide(width:1,color: Colors.transparent)),
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: BorderSide(width:1,color: Colors.red.withOpacity(.4))),

        ),
        validator:widget.validator?? (value){
          if(value!=null&&value.isEmpty){
            return "من فضلك تاكد من تلك المعلومات ";
          }else {
            return null;
          }
        },
      ),
    );
  }
}
