import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasky/Features/Auth/presentation/view_model/auth_cubit.dart';
import 'package:tasky/Features/Auth/presentation/view_model/auth_state.dart';
import 'package:tasky/Features/Auth/presentation/views/profile_info_view.dart';
import 'package:tasky/Features/Auth/presentation/views/sign_in_view.dart';
import 'package:tasky/core/text_styles.dart';
import 'package:tasky/core/widgets/custom_error%20_snack_bar.dart';
import 'package:tasky/core/widgets/custom_logout_button.dart';
import 'package:tasky/core/widgets/custom_success_snack_bar.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubitCubit, AuthCubitState>(
      listener: (context, state) {
        if (state is LogoutSuccessState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            SignInView.routeName,
            (route) => false,
          );
          CustomSuccessSnackbar.showSuccess(
              context: context, message: state.message);
        }
        if (state is LogoutErrorState) {
          CustomSnackbar.showError(
              context: context, message: state.errorMessage);
        }
      },
      child: Row(
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
          GestureDetector(
            onTap: () {
              BlocProvider.of<AuthCubitCubit>(context).getProfile();
              Navigator.pushNamed(context, ProfileInfoView.routeName);
            },
            child: const Icon(
              FontAwesomeIcons.circleUser,
              size: 24,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          const LogoutButton()
        ],
      ),
    );
  }
}
