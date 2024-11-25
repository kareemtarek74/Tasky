import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tasky/Features/Auth/presentation/view_model/auth_cubit.dart';
import 'package:tasky/Features/Auth/presentation/view_model/auth_state.dart';
import 'package:tasky/Features/Auth/presentation/views/widgets/profile_info_list_view.dart';
import 'package:tasky/Features/Auth/presentation/views/widgets/profile_info_model.dart';
import 'package:tasky/core/widgets/custom_app_bar.dart';
import 'package:tasky/core/widgets/custom_progress_indicator.dart';

import '../../../../../core/widgets/custom_error _snack_bar.dart';

class ProfileInfoViewBody extends StatelessWidget {
  const ProfileInfoViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(
              title: 'Profile',
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.5),
                child: BlocConsumer<AuthCubitCubit, AuthCubitState>(
                  listener: (context, state) {
                    if (state is ProfileInfoErrorState) {
                      CustomSnackbar.showError(
                        context: context,
                        message: state.errorMessage.toString(),
                        actionLabel: 'Retry',
                        onAction: () =>
                            BlocProvider.of<AuthCubitCubit>(context).getProfile,
                      );
                    }
                  },
                  builder: (context, state) {
                    return ModalProgressHUD(
                      inAsyncCall:
                          state is ProfileInfoLoadingState ? true : false,
                      progressIndicator: const CustomProgressIndicator(),
                      child: state is ProfileInfoSuccessState
                          ? ProfileInfoListView(
                              user: [
                                ProfileInfoModel(
                                    title: 'NAME',
                                    subTitle:
                                        state.profileInfoEntity.name ?? ''),
                                ProfileInfoModel(
                                    title: 'PHONE',
                                    subTitle:
                                        state.profileInfoEntity.phone ?? ''),
                                ProfileInfoModel(
                                    title: 'LEVEL',
                                    subTitle:
                                        state.profileInfoEntity.leveL ?? ''),
                                ProfileInfoModel(
                                    title: 'YEARS OF EXPERIENCE',
                                    subTitle: state.profileInfoEntity.experience
                                        .toString()),
                                ProfileInfoModel(
                                    title: 'LOCATION',
                                    subTitle:
                                        state.profileInfoEntity.location ?? ''),
                              ],
                            )
                          : const SizedBox(),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
