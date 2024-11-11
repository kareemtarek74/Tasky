import 'package:flutter/material.dart';
import 'package:tasky/Features/Auth/presentation/views/sign_in_view.dart';
import 'package:tasky/core/text_styles.dart';
import 'package:tasky/core/utils/app_colors.dart';

class AlreadyHaveAccount extends StatelessWidget {
  const AlreadyHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacementNamed(SignInView.routeName);
      },
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
                text: 'Already have any account? ',
                style: Styles.styleRegular14(context)),
            TextSpan(
              text: 'Sign in',
              style: Styles.styleBold14(context).copyWith(
                color: AppColors.primaryColor,
                decoration: TextDecoration.underline,
                height: 0.10,
                letterSpacing: 0.20,
              ),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
