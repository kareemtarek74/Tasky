import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/utils/app_images.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    this.style,
    required this.hasIcon,
    required this.onPressed,
  });
  final String text;
  final TextStyle? style;
  final bool hasIcon;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            fixedSize: Size(MediaQuery.sizeOf(context).width, 49),
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: style,
            ),
            const SizedBox(
              width: 8,
            ),
            Visibility(
              visible: hasIcon,
              child: SvgPicture.asset(
                Assets.imagesArrow,
                width: 24,
              ),
            ),
          ],
        ));
  }
}
