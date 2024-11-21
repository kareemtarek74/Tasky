import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tasky/Features/Auth/presentation/view_model/auth_cubit.dart';
import 'package:tasky/Features/Auth/presentation/view_model/auth_state.dart';
import 'package:tasky/Features/Auth/presentation/views/widgets/sign_up_view_body.dart';
import 'package:tasky/core/widgets/custom_progress_indicator.dart';
import 'package:tasky/core/widgets/custom_error%20_snack_bar.dart';
import 'package:tasky/core/widgets/custom_success_snack_bar.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});
  static const routeName = 'sign-up';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubitCubit, AuthCubitState>(
      listener: (context, state) {
        if (state is RegisterSuccessState) {
          CustomSuccessSnackbar.showSuccess(
            context: context,
            message: "Welcome! Your account has been successfully created.",
            actionLabel: "Undo",
            onAction: () {},
          );
        }
        if (state is RegisterErrorState) {
          CustomSnackbar.showError(
            context: context,
            message: state.errorMessage.toString(),
            actionLabel: 'Retry',
            onAction: () =>
                BlocProvider.of<AuthCubitCubit>(context).registerUser(),
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
            inAsyncCall: state is RegisterLoadingState ? true : false,
            progressIndicator: const CustomProgressIndicator(),
            child: const SignUpViewBody());
      },
    );
  }
}
