import 'package:equatable/equatable.dart';

abstract class PhoneState extends Equatable {
  const PhoneState();

  @override
  List<Object?> get props => [];
}

class PhoneInitial extends PhoneState {
  final String countryCode;

  const PhoneInitial({this.countryCode = 'EG'});

  @override
  List<Object?> get props => [countryCode];
}

class PhoneValid extends PhoneState {
  final String phoneNumber;

  const PhoneValid({required this.phoneNumber});

  @override
  List<Object?> get props => [phoneNumber];
}

class PhoneInvalid extends PhoneState {
  final String errorMessage;

  const PhoneInvalid({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
