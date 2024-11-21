import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tasky/Features/Auth/presentation/view_model/auth_cubit.dart';
import 'package:tasky/Features/Auth/presentation/view_model/auth_state.dart';
import 'package:tasky/Features/Auth/presentation/views/widgets/sign_in_view_body.dart';
import 'package:tasky/core/widgets/custom_progress_indicator.dart';
import 'package:tasky/core/widgets/custom_error%20_snack_bar.dart';
import 'package:tasky/core/widgets/custom_success_snack_bar.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  static const String routeName = 'sign-in';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubitCubit, AuthCubitState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          CustomSuccessSnackbar.showSuccess(
            context: context,
            message: "You’re now logged in. Enjoy your session!",
          );
        }
        if (state is LoginErrorState) {
          CustomSnackbar.showError(
            context: context,
            message: state.errorMessage.toString(),
            actionLabel: 'Retry',
            onAction: () =>
                BlocProvider.of<AuthCubitCubit>(context).loginUser(),
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
            inAsyncCall: state is LoginLoadingState ? true : false,
            progressIndicator: const CustomProgressIndicator(),
            child: const SignInViewBody());
      },
    );
  }
}
