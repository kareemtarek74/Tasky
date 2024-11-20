import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/Features/Auth/presentation/view_model/auth_cubit.dart';
import 'package:tasky/Features/Auth/presentation/views/widgets/already_have_account.dart';
import 'package:tasky/Features/Auth/presentation/views/widgets/experience_level_drop_down.dart';
import 'package:tasky/core/text_styles.dart';
import 'package:tasky/core/utils/app_images.dart';
import 'package:tasky/core/widgets/custom_button.dart';
import 'package:tasky/core/widgets/custom_password_field.dart';
import 'package:tasky/core/widgets/custom_phone_field.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';

class SignUpViewBody extends StatefulWidget {
  const SignUpViewBody({super.key});

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: BlocProvider.of<AuthCubitCubit>(context).registerFormKey,
          autovalidateMode: autovalidateMode,
          child: Stack(
            children: [
              // Background Image
              Container(
                height: 380,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: const Image(
                  image: AssetImage(Assets.imagesSignUPAvatar),
                  width: double.infinity,
                  height: 380,
                  fit: BoxFit.cover,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                        height: 230), // Give enough space from the top image

                    Text(
                      'Login',
                      style: Styles.styleBold24(context),
                    ),
                    const SizedBox(height: 24),
                    CustomTextFormField(
                      controller: BlocProvider.of<AuthCubitCubit>(context)
                          .registerNameController,
                      hintText: 'Name...',
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 16),

                    CustomPhoneField(
                      controller: BlocProvider.of<AuthCubitCubit>(context)
                          .registerPhoneController,
                    ),
                    const SizedBox(height: 16),

                    // Experience Field
                    CustomTextFormField(
                      controller: BlocProvider.of<AuthCubitCubit>(context)
                          .registerExperienceController,
                      hintText: 'Years of experience...',
                      keyboardType: TextInputType.number,
                    ),
                    const SizedBox(height: 16),

                    // Experience Level Dropdown
                    ExperienceLevelDropdown(),
                    const SizedBox(height: 16),

                    // Address Field
                    CustomTextFormField(
                      controller: BlocProvider.of<AuthCubitCubit>(context)
                          .registerAddressController,
                      hintText: 'Address...',
                    ),
                    const SizedBox(height: 16),

                    // Password Field
                    CustomPasswordField(
                      controller: BlocProvider.of<AuthCubitCubit>(context)
                          .registerPasswordController,
                    ),
                    const SizedBox(height: 24),

                    // Sign Up Button
                    CustomButton(
                      text: 'Sign up',
                      hasIcon: false,
                      onPressed: () {
                        if (BlocProvider.of<AuthCubitCubit>(context)
                            .registerFormKey
                            .currentState!
                            .validate()) {
                          BlocProvider.of<AuthCubitCubit>(context)
                              .registerUser();
                        } else {
                          setState(() {
                            autovalidateMode = AutovalidateMode.always;
                          });
                        }
                      },
                      style: Styles.styleBold16(context)
                          .copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 24), // Space below the button

                    // Already have an account
                    const AlreadyHaveAccount(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
