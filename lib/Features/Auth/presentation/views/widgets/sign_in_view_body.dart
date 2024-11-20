import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/Features/Auth/presentation/view_model/auth_cubit.dart';
import 'package:tasky/Features/Auth/presentation/view_model/auth_state.dart';
import 'package:tasky/Features/Auth/presentation/views/widgets/dont_have_account.dart';
import 'package:tasky/core/text_styles.dart';
import 'package:tasky/core/utils/app_images.dart';
import 'package:tasky/core/widgets/custom_button.dart';
import 'package:tasky/core/widgets/custom_password_field.dart';
import 'package:tasky/core/widgets/custom_phone_field.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';

class SignInViewBody extends StatefulWidget {
  const SignInViewBody({super.key});

  @override
  State<SignInViewBody> createState() => _SignInViewBodyState();
}

class _SignInViewBodyState extends State<SignInViewBody> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: BlocProvider.of<AuthCubitCubit>(context).loginFormKey,
            autovalidateMode: autovalidateMode,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(children: [
                  const Image(
                    width: double.infinity,
                    fit: BoxFit.cover,
                    image: AssetImage(Assets.imagesAvatar),
                  ),
                  Positioned(
                    bottom: 100,
                    left: 24.5,
                    child: Text(
                      'Login',
                      style: Styles.styleBold24(context),
                    ),
                  ),
                  Positioned(
                      bottom: 20,
                      left: 24.5,
                      right: 24.5,
                      child: CustomPhoneField(
                        controller:
                            context.read<AuthCubitCubit>().loginPhoneController,
                        initialCountryCode: 'EG',
                        onPhoneChanged: (completeNumber, number) {
                          context
                              .read<AuthCubitCubit>()
                              .validatePhoneNumber(completeNumber, number);
                        },
                        onCountryChanged: (dialCode, minLength, maxLength) {
                          context.read<AuthCubitCubit>().updateCountryCode(
                              dialCode, minLength, maxLength);
                        },
                      )),
                ]),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.5),
                  child: Column(
                    children: [
                      CustomPasswordField(
                        controller: context
                            .read<AuthCubitCubit>()
                            .loginPasswordController,
                      ),
                      const SizedBox(height: 24),
                      CustomButton(
                        onPressed: () {
                          if (BlocProvider.of<AuthCubitCubit>(context)
                              .loginFormKey
                              .currentState!
                              .validate()) {
                            BlocProvider.of<AuthCubitCubit>(context)
                                .loginUser();
                          } else {
                            setState(() {
                              autovalidateMode = AutovalidateMode.always;
                            });
                          }
                          final cubit = context.read<AuthCubitCubit>();
                          final state = cubit.state;
                          if (state is PhoneValid) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('Welcome ${state.phoneNumber}')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      'Please enter a right phone number.')),
                            );
                          }
                        },
                        text: 'Sign In',
                        style: Styles.styleBold16(context)
                            .copyWith(color: Colors.white),
                        hasIcon: false,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const DidntHaveAccount()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
