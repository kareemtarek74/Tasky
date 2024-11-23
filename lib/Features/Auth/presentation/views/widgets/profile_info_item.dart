import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:tasky/Features/Auth/presentation/views/widgets/profile_info_model.dart';
import 'package:tasky/core/text_styles.dart';
import 'package:tasky/core/utils/app_colors.dart';

class ProfileInfoItem extends StatelessWidget {
  const ProfileInfoItem({
    super.key,
    required this.profileInfoModel,
    this.showIcon = false,
  });
  final ProfileInfoModel profileInfoModel;
  final bool showIcon;
  @override
  Widget build(BuildContext context) {
    return Card(
        color: const Color(0xffF5F5F5),
        elevation: 0,
        child: ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text(
              profileInfoModel.title,
              style: Styles.styleMedium12(context)
                  .copyWith(color: const Color(0x662F2F2F)),
            ),
            subtitle: Text(profileInfoModel.subTitle,
                style: Styles.styleBold18(context)
                    .copyWith(color: const Color(0x992F2F2F))),
            contentPadding: const EdgeInsets.only(left: 15, right: 8),
            trailing: showIcon
                ? IconButton(
                    icon: const Icon(
                      FontAwesomeIcons.clone,
                      size: 24,
                      color: AppColors.primaryColor,
                    ),
                    onPressed: () {
                      final data = profileInfoModel.subTitle;
                      Clipboard.setData(ClipboardData(text: data));
                      MotionToast.success(
                        title: const Text(
                          "Copied!",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        description: Text("Copied: $data"),
                        animationType: AnimationType.fromBottom,
                        position: MotionToastPosition.bottom,
                        width: 300,
                      ).show(context);
                    },
                  )
                : const SizedBox()));
  }
}
