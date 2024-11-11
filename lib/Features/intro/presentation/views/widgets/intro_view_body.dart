import 'package:flutter/material.dart';
import 'package:tasky/Features/Auth/presentation/views/sign_in_view.dart';
import 'package:tasky/constants.dart';
import 'package:tasky/core/services/shared_preferences_singleton.dart';
import 'package:tasky/core/text_styles.dart';
import 'package:tasky/core/utils/app_images.dart';
import 'package:tasky/core/utils/app_texts.dart';
import 'package:tasky/core/widgets/custom_button.dart';

class IntroViewBody extends StatelessWidget {
  const IntroViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(children: [
          const Image(
            width: double.infinity,
            fit: BoxFit.cover,
            image: AssetImage(Assets.imagesAvatar),
          ),
          Positioned(
            bottom: 15,
            left: 0,
            right: 0,
            child: Text(
              AppTexts.introTitle,
              style: Styles.styleBold24(context),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
        ]),
        Text(
          AppTexts.introSubTitle,
          style: Styles.styleRegular14(context).copyWith(
            height: 24 / 14,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 32,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: CustomButton(
            onPressed: () {
              Prefs.setBool(kIsIntroViewSeen, true);
              Navigator.of(context).pushReplacementNamed(SignInView.routeName);
            },
            text: 'Let’s Start',
            style: Styles.styleBold19(context),
            hasIcon: true,
          ),
        ),
      ],
    );
  }
}
