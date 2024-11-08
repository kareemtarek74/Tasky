import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tasky/Features/Auth/presentation/views/sign_in_view.dart';
import 'package:tasky/core/text_styles.dart';
import 'package:tasky/core/utils/app_images.dart';

class CustomIntroButton extends StatelessWidget {
  const CustomIntroButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(SignInView.routeName);
        },
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
            fixedSize: Size(MediaQuery.sizeOf(context).width, 49),
            backgroundColor: const Color(0xff5F33E1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            )),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 6,
            ),
            Text(
              'Let’s Start',
              style: Styles.styleBold19(context),
            ),
            const Spacer(),
            SvgPicture.asset(
              Assets.imagesArrow,
              width: 24,
            ),
            const Spacer(
              flex: 6,
            )
          ],
        ));
  }
}
