import 'package:flutter/material.dart';
import 'package:tasky/core/text_styles.dart';
import 'package:tasky/core/utils/app_images.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                const Image(
                  image: AssetImage(Assets.imagesSignUPAvatar),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 90,
                  left: 24.5,
                  child: Text(
                    'Login',
                    style: Styles.styleBold24(context),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
