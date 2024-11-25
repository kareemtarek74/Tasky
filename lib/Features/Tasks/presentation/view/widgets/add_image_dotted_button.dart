import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:tasky/core/text_styles.dart';

class AddImageButton extends StatelessWidget {
  const AddImageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.RRect,
      color: const Color(0xFF5F33E1),
      strokeWidth: 1.5,
      dashPattern: const [2, 2],
      radius: const Radius.circular(12),
      child: SizedBox(
        height: 56,
        width: double.infinity,
        child: TextButton.icon(
          onPressed: () {},
          icon: const Icon(
            Icons.add_photo_alternate_outlined,
            color: Color(0xFF5F33E1),
            size: 24,
          ),
          label: Text('Add Img', style: Styles.styleMedium19(context)),
          style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 12),
            foregroundColor: const Color(0xFF5F33E1),
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
