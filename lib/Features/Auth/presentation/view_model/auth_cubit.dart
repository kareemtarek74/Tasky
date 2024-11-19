import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:tasky/Features/Auth/Domain/repos/register_repo.dart';

import 'auth_state.dart';

class AuthCubitCubit extends Cubit<AuthCubitState> {
  int minPhoneLength = 10;
  int maxPhoneLength = 15;
  final RegisterRepo registerRepo;

  AuthCubitCubit({required this.registerRepo})
      : super(const AuthCubitInitial());

  final registerFormKey = GlobalKey<FormState>();
  final registerNameController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerPhoneController = TextEditingController();
  final registerExperienceController = TextEditingController();
  final registerAddressController = TextEditingController();

  void updateCountryCode(String newCode, int minLength, int maxLength) {
    minPhoneLength = minLength;
    maxPhoneLength = maxLength;
    emit(AuthCubitInitial(countryCode: newCode));
  }

  void validatePhoneNumber(String completeNumber, String phoneNumber) {
    if (phoneNumber.length >= minPhoneLength &&
        phoneNumber.length <= maxPhoneLength) {
      emit(PhoneValid(phoneNumber: completeNumber));
    } else {
      emit(PhoneInvalid(
          errorMessage:
              "Phone number should be between $minPhoneLength and $maxPhoneLength digits."));
    }
  }

  String? levelSelected;
  void selectExperienceLevel(String level) {
    levelSelected = level;
    emit(ExperienceLevelSelected(level));
  }

  Future<void> registerUser() async {
    emit(RegisterLoadingState());
    final response = await registerRepo.registerUser(
      name: registerNameController.text,
      phone: registerPhoneController.text,
      password: registerPasswordController.text,
      address: registerAddressController.text,
      yearsOfExperience: int.tryParse(registerExperienceController.text),
      experienceLevel: levelSelected,
    );
    response.fold((error) {
      emit(RegisterErrorState(error));
    }, (userEntity) {
      emit(RegisterSuccessState(registerEntity: userEntity));
    });
  }
}
