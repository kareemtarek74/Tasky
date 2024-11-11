import 'package:flutter/material.dart';
import 'package:tasky/core/text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key, this.keyboardType, required this.hintText, this.suffixIcon});
  final TextInputType? keyboardType;
  final String hintText;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: Styles.styleRegular14(context),
          contentPadding: const EdgeInsets.all(15),
          border: buildBorder(),
          focusedBorder: buildBorder(),
          enabledBorder: buildBorder()),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(width: 1, color: Color(0xffBABABA)));
  }
}
