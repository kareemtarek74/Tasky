import 'package:flutter/material.dart';
import 'package:tasky/core/text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.keyboardType,
      required this.hintText,
      this.suffixIcon,
      this.controller,
      this.obscureText = false});
  final TextInputType? keyboardType;
  final String hintText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'It is required';
        }
        return null;
      },
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: Styles.styleRegular14(context)
              .copyWith(color: const Color(0xff7F7F7F)),
          contentPadding: const EdgeInsets.all(15),
          border: buildBorder(),
          focusedBorder: buildBorder(),
          enabledBorder: buildBorder(),
          errorBorder: buildErrorBorder(),
          focusedErrorBorder: buildErrorBorder()),
    );
  }

  OutlineInputBorder buildErrorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(width: 1, color: Colors.red),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(width: 1, color: Color(0xffBABABA)));
  }
}
