import 'package:flutter/material.dart';
import 'package:schaffen_software/utils/validator.dart';
import 'ColorGlobal.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;
  final IconData? suffixIconData;
  final bool obscureText;
  final void Function(String)? onChanged;
  var validator;
  final FocusNode focusNode;
  final TextEditingController textEditingController;

  TextFieldWidget({
    required this.hintText,
    required this.prefixIconData,
    this.suffixIconData,
    required this.obscureText,
    this.onChanged,
    required this.validator,
    required this.textEditingController,
    required this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      obscureText: obscureText,
      controller: textEditingController,
      cursorColor: ColorGlobal.colorPrimary,
      focusNode: focusNode,
      validator: validator,
      style: TextStyle(
        color: ColorGlobal.whiteColor,
        fontWeight: FontWeight.w600,
        fontSize: 16.0,
      ),
      decoration: InputDecoration(
        labelStyle: TextStyle(color: ColorGlobal.whiteColor),
        focusColor: ColorGlobal.whiteColor,
        filled: true,
        enabledBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: ColorGlobal.whiteColor),
        ),
        labelText: hintText,
        hintStyle: TextStyle(color: ColorGlobal.colorPrimary, fontSize: 14),
        prefixIcon: Icon(
          prefixIconData,
          size: 20,
          color: ColorGlobal.whiteColor,
        ),
        suffixIcon: GestureDetector(
          child: Icon(
            suffixIconData,
            size: 20,
            color: ColorGlobal.whiteColor,
          ),
        ),
      ),
    );
  }
}
