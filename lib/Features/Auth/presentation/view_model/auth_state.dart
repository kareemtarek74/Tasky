import 'package:equatable/equatable.dart';
import 'package:tasky/Features/Auth/Domain/Entites/login_entity.dart';
import 'package:tasky/Features/Auth/Domain/Entites/register_entity.dart';

abstract class AuthCubitState extends Equatable {
  const AuthCubitState();

  @override
  List<Object?> get props => [];
}

class AuthCubitInitial extends AuthCubitState {
  final String countryCode;

  const AuthCubitInitial({this.countryCode = 'EG'});

  @override
  List<Object?> get props => [countryCode];
}

class PhoneValid extends AuthCubitState {
  final String phoneNumber;

  const PhoneValid({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

class PhoneInvalid extends AuthCubitState {
  final String errorMessage;

  const PhoneInvalid({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class ExperienceLevelSelected extends AuthCubitState {
  final String selectedLevel;

  const ExperienceLevelSelected(this.selectedLevel);

  @override
  List<Object> get props => [selectedLevel];
}

class RegisterLoadingState extends AuthCubitState {}

class RegisterSuccessState extends AuthCubitState {
  final RegisterEntity registerEntity;

  const RegisterSuccessState({required this.registerEntity});

  @override
  List<Object?> get props => [registerEntity];
}

class RegisterErrorState extends AuthCubitState {
  final String? errorMessage;

  const RegisterErrorState(this.errorMessage);
}

class LoginLoadingState extends AuthCubitState {}

class LoginSuccessState extends AuthCubitState {
  final LoginEntity loginEntity;

  const LoginSuccessState({required this.loginEntity});

  @override
  List<Object?> get props => [loginEntity];
}

class LoginErrorState extends AuthCubitState {
  final String? errorMessage;

  const LoginErrorState(this.errorMessage);
}
