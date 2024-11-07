import 'package:flutter/material.dart';
import 'package:tasky/core/text_styles.dart';
import 'package:tasky/core/utils/app_images.dart';

class IntroViewBody extends StatelessWidget {
  const IntroViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(children: [
          Image.asset(Assets.imagesAvatar),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  'Task Management &\nTo-Do List',
                  style: Styles.styleBold24(context),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'This productive tool is designed to help\nyou better manage your task\nproject-wise conveniently!',
                  style: Styles.styleRegular16(context).copyWith(),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ]),
        const SizedBox(
          height: 32,
        ),ElevatedButton(onPressed: () {}, child: const Text('Get Started')),
      ],
    );
  }
}
