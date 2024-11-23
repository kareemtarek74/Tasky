import 'package:flutter/material.dart';
import 'package:tasky/Features/Auth/presentation/views/widgets/profile_info_item.dart';
import 'package:tasky/Features/Auth/presentation/views/widgets/profile_info_model.dart';

class ProfileInfoListView extends StatelessWidget {
  const ProfileInfoListView({super.key, required this.user});
  final List<ProfileInfoModel> user;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
            children: user.asMap().entries.map((entry) {
          final index = entry.key;
          final profileInfoModel = entry.value;
          return IntrinsicHeight(
            child: ProfileInfoItem(
              profileInfoModel: profileInfoModel,
              showIcon: index == 1,
            ),
          );
        }).toList()));
  }
}
