import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
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
              ],
            ),
          ),
        ]),
        Text(
          'This productive tool is designed to help\nyou better manage your task\nproject-wise conveniently!',
          style: Styles.styleRegular14(context).copyWith(),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 32,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: ElevatedButton(
              onPressed: () {},
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
              )),
        ),
      ],
    );
  }
}
