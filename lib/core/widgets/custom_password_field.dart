import 'package:flutter/material.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';

class CustomPasswordField extends StatefulWidget {
  const CustomPasswordField({
    super.key,
    this.controller,
  });
  final TextEditingController? controller;

  @override
  State<CustomPasswordField> createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  bool obscureText = true;
  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      obscureText: obscureText,
      controller: widget.controller,
      hintText: 'Password...',
      suffixIcon: GestureDetector(
        onTap: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
        child: const Icon(
          Icons.remove_red_eye_outlined,
          color: Color(0xffBABABA),
          size: 22,
        ),
      ),
    );
  }
}
