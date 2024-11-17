import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/Features/Auth/presentation/view_model/phone_cubit.dart';
import 'package:tasky/Features/Auth/presentation/view_model/phone_state.dart';
import 'package:tasky/Features/Auth/presentation/views/widgets/dont_have_account.dart';
import 'package:tasky/core/text_styles.dart';
import 'package:tasky/core/utils/app_images.dart';
import 'package:tasky/core/widgets/custom_button.dart';
import 'package:tasky/core/widgets/custom_phone_field.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';

class SignInViewBody extends StatelessWidget {
  const SignInViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PhoneCubit(),
      child: BlocBuilder<PhoneCubit, PhoneState>(
        builder: (context, state) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: SingleChildScrollView(
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
                            initialCountryCode: 'EG',
                            onPhoneChanged: (completeNumber, number) {
                              context
                                  .read<PhoneCubit>()
                                  .validatePhoneNumber(completeNumber, number);
                            },
                            onCountryChanged: (dialCode, minLength, maxLength) {
                              context.read<PhoneCubit>().updateCountryCode(
                                  dialCode, minLength, maxLength);
                            },
                          )),
                    ]),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.5),
                      child: Column(
                        children: [
                          const CustomTextFormField(
                            hintText: 'Password...',
                            suffixIcon: Icon(
                              Icons.remove_red_eye_outlined,
                              color: Color(0xffBABABA),
                              size: 22,
                            ),
                          ),
                          const SizedBox(height: 24),
                          CustomButton(
                            onPressed: () {
                              final cubit = context.read<PhoneCubit>();
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
              ));
        },
      ),
    );
  }
}
