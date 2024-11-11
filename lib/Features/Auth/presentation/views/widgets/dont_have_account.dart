import 'package:flutter/material.dart';
import 'package:tasky/Features/Auth/presentation/views/sign_up_view.dart';
import 'package:tasky/core/text_styles.dart';
import 'package:tasky/core/utils/app_colors.dart';

class DidntHaveAccount extends StatelessWidget {
  const DidntHaveAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacementNamed(context, SignUpView.routeName);
      },
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
                text: 'Didn’t have any account? ',
                style: Styles.styleRegular14(context)),
            TextSpan(
              text: 'Sign Up here',
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
