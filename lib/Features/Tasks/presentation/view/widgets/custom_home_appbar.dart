import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasky/core/text_styles.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            'Logo',
            style: Styles.styleBold24(context)
                .copyWith(color: const Color(0xff24252C)),
          ),
        ),
        const Spacer(),
        const Icon(
          FontAwesomeIcons.circleUser,
          size: 24,
        ),
        const SizedBox(
          width: 20,
        ),
        const Icon(
          Icons.logout,
          size: 24,
          color: Color(0xff5F33E1),
        )
      ],
    );
  }
}
