import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/Features/Auth/Domain/usecases/login_usecase.dart';
import 'package:tasky/Features/Auth/Domain/usecases/logout_usecase.dart';
import 'package:tasky/Features/Auth/Domain/usecases/profile_info_usecase.dart';
import 'package:tasky/Features/Auth/Domain/usecases/refresh_token_usecase.dart';
import 'package:tasky/Features/Auth/Domain/usecases/register_usecase.dart';
import 'package:tasky/core/Api/end_points.dart';
import 'package:tasky/core/UseCase/app_usecases.dart';

import 'auth_state.dart';

class AuthCubitCubit extends Cubit<AuthCubitState> {
  int minPhoneLength = 10;
  int maxPhoneLength = 15;
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final ProfileInfoUsecase profileInfoUsecase;
  final RefreshTokenUsecase refreshTokenUsecase;
  final UserLogoutUsecase userLogoutUsecase;
  final SharedPreferences sharedPreferences;

  AuthCubitCubit(
      {required this.sharedPreferences,
      required this.profileInfoUsecase,
      required this.userLogoutUsecase,
      required this.refreshTokenUsecase,
      required this.loginUsecase,
      required this.registerUsecase})
      : super(const AuthCubitInitial());

  final registerFormKey = GlobalKey<FormState>();
  final loginFormKey = GlobalKey<FormState>();
  final registerNameController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerPhoneController = TextEditingController();
  final registerExperienceController = TextEditingController();
  final registerAddressController = TextEditingController();
  final loginPhoneController = TextEditingController();
  final loginPasswordController = TextEditingController();

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
    final params = RegisterParams(
      displayName: registerNameController.text,
      phone: registerPhoneController.text,
      password: registerPasswordController.text,
      address: registerAddressController.text,
      experienceYears: int.tryParse(registerExperienceController.text)!,
      level: levelSelected.toString(),
    );
    final response = await registerUsecase.call(params);
    response.fold((error) {
      emit(RegisterErrorState(error));
    }, (userEntity) {
      emit(RegisterSuccessState(registerEntity: userEntity));
    });
  }

  Future<void> loginUser() async {
    emit(LoginLoadingState());
    final params = LoginParams(
        phone: loginPhoneController.text,
        password: loginPasswordController.text);
    final response = await loginUsecase.call(params);

    response.fold((error) {
      emit(LoginErrorState(error));
    }, (loginentity) {
      emit(LoginSuccessState(loginEntity: loginentity));
    });
  }

  Future<void> refreshToken() async {
    try {
      emit(RefreshTokenLoadingState());

      final refreshResult = await refreshTokenUsecase.call(NoParam());

      refreshResult.fold(
        (error) {
          emit(RefreshTokenErrorState(error));
        },
        (refreshTokenEntity) {
          final newAccessToken = refreshTokenEntity.accesstoken.toString();
          sharedPreferences.setString(ApiKeys.accessToken, newAccessToken);

          emit(RefreshTokenSuccessState());
        },
      );
    } catch (e) {
      emit(RefreshTokenErrorState(e.toString()));
    }
  }

  Future<void> logoutUser() async {
    final response = await userLogoutUsecase.call(NoParam());
    response.fold((error) {
      emit(LogoutErrorState(errorMessage: error));
    }, (logoutSuccess) {
      emit(LogoutSuccessState(message: logoutSuccess));
    });
  }

  Future<void> getProfile() async {
    emit(ProfileInfoLoadingState());
    final response = await profileInfoUsecase.call(NoParam());
    response.fold((error) {
      emit(ProfileInfoErrorState(error));
    }, (profileEntity) {
      emit(ProfileInfoSuccessState(profileInfoEntity: profileEntity));
    });
  }
}
