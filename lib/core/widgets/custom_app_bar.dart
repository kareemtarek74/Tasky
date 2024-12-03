import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/Features/Auth/presentation/views/widgets/custom_drop_down_menu.dart';
import 'package:tasky/core/text_styles.dart';
import 'package:tasky/core/utils/app_images.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key,
      required this.title,
      this.hasIcon = false,
      this.padding = const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
      this.id = '0'});
  final String title;
  final bool hasIcon;
  final EdgeInsetsGeometry padding;
  final String id;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Transform.rotate(
            angle: 3.14159,
            child: SvgPicture.asset(
              Assets.imagesArrow,
              height: 12,
              width: 18,
              colorFilter:
                  const ColorFilter.mode(Colors.black, BlendMode.srcIn),
            ),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          title,
          style: Styles.styleBold16(context),
        ),
        const Spacer(),
        Visibility(
            visible: hasIcon,
            child: CustomDropdown(
              id: id,
              iconSize: 28,
            ))
      ]),
    );
  }
}
