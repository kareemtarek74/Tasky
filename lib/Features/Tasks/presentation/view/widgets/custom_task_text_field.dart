import 'package:flutter/material.dart';

import '../../../../../core/text_styles.dart';

class CustomTaskTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final int maxLines;

  const CustomTaskTextField({
    required this.label,
    required this.hintText,
    this.maxLines = 1,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: Styles.styleRegular12(context)
                .copyWith(color: const Color(0xff6E6A7C))),
        const SizedBox(height: 8),
        TextField(
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: Styles.styleRegular14(context)
                .copyWith(color: const Color(0xff7F7F7F)),
            border: buildBorder(),
            enabledBorder: buildBorder(),
            focusedBorder: buildBorder(),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
          ),
        ),
      ],
    );
  }
}

OutlineInputBorder buildBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(width: 1, color: Color(0xFFBABABA)));
}
