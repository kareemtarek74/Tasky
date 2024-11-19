import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/Features/Auth/presentation/view_model/auth_cubit.dart';
import 'package:tasky/Features/Auth/presentation/views/widgets/already_have_account.dart';
import 'package:tasky/Features/Auth/presentation/views/widgets/experience_level_drop_down.dart';
import 'package:tasky/core/text_styles.dart';
import 'package:tasky/core/utils/app_images.dart';
import 'package:tasky/core/widgets/custom_button.dart';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  Container(
                    height: 780,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  const Image(
                    image: AssetImage(Assets.imagesSignUPAvatar),
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    bottom: 490,
                    left: 24.5,
                    child: Text(
                      'Login',
                      style: Styles.styleBold24(context),
                    ),
                  ),
                  Positioned(
                    bottom: 425,
                    left: 24.5,
                    right: 24.5,
                    child: CustomTextFormField(
                      controller: BlocProvider.of<AuthCubitCubit>(context)
                          .registerNameController,
                      hintText: 'Name...',
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  Positioned(
                    bottom: 360,
                    left: 24.5,
                    right: 24.5,
                    child: CustomPhoneField(
                      controller: BlocProvider.of<AuthCubitCubit>(context)
                          .registerPhoneController,
                    ),
                  ),
                  Positioned(
                    bottom: 295,
                    left: 24.5,
                    right: 24.5,
                    child: CustomTextFormField(
                      controller: BlocProvider.of<AuthCubitCubit>(context)
                          .registerExperienceController,
                      hintText: 'Years of experience...',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Positioned(
                    bottom: 230,
                    left: 24.5,
                    right: 24.5,
                    child: ExperienceLevelDropdown(),
                  ),
                  Positioned(
                    bottom: 165,
                    left: 24.5,
                    right: 24.5,
                    child: CustomTextFormField(
                        controller: BlocProvider.of<AuthCubitCubit>(context)
                            .registerAddressController,
                        hintText: 'Address...'),
                  ),
                  Positioned(
                    bottom: 100,
                    left: 24.5,
                    right: 24.5,
                    child: CustomTextFormField(
                      controller: BlocProvider.of<AuthCubitCubit>(context)
                          .registerPasswordController,
                      hintText: 'Password...',
                      suffixIcon: const Icon(
                        Icons.remove_red_eye_outlined,
                        color: Color(0xffBABABA),
                        size: 22,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    left: 24.5,
                    right: 24.5,
                    child: CustomButton(
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
                  ),
                ],
              ),
              const AlreadyHaveAccount()
            ],
          ),
        ),
      ),
    );
  }
}
