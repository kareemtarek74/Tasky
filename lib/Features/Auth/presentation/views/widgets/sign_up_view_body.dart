import 'package:flutter/material.dart';
import 'package:tasky/Features/Auth/presentation/views/widgets/already_have_account.dart';
import 'package:tasky/Features/Auth/presentation/views/widgets/experience_level_drop_down.dart';
import 'package:tasky/core/text_styles.dart';
import 'package:tasky/core/utils/app_images.dart';
import 'package:tasky/core/widgets/custom_button.dart';
import 'package:tasky/core/widgets/custom_phone_field.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';

class SignUpViewBody extends StatelessWidget {
  const SignUpViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.sizeOf(context).height,
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
                const Positioned(
                  bottom: 425,
                  left: 24.5,
                  right: 24.5,
                  child: CustomTextFormField(
                    hintText: 'Name...',
                    keyboardType: TextInputType.name,
                  ),
                ),
                const Positioned(
                  bottom: 360,
                  left: 24.5,
                  right: 24.5,
                  child: CustomPhoneField(),
                ),
                const Positioned(
                  bottom: 295,
                  left: 24.5,
                  right: 24.5,
                  child: CustomTextFormField(
                    hintText: 'Years of experience...',
                    keyboardType: TextInputType.number,
                  ),
                ),
                const Positioned(
                  bottom: 230,
                  left: 24.5,
                  right: 24.5,
                  child: ExperienceLevelDropdown(),
                ),
                const Positioned(
                  bottom: 165,
                  left: 24.5,
                  right: 24.5,
                  child: CustomTextFormField(hintText: 'Address...'),
                ),
                const Positioned(
                  bottom: 100,
                  left: 24.5,
                  right: 24.5,
                  child: CustomTextFormField(
                    hintText: 'Password...',
                    suffixIcon: Icon(
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
                    onPressed: () {},
                    style: Styles.styleBold16(context)
                        .copyWith(color: Colors.white),
                  ),
                ),
                const Positioned(
                  bottom: 5,
                  left: 24.5,
                  right: 24.5,
                  child: AlreadyHaveAccount(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
