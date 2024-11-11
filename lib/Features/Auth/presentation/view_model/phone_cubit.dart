import 'package:bloc/bloc.dart';

import 'phone_state.dart';

class PhoneCubit extends Cubit<PhoneState> {
  int minPhoneLength = 10;
  int maxPhoneLength = 15;

  PhoneCubit() : super(const PhoneInitial());

  void updateCountryCode(String newCode, int minLength, int maxLength) {
    minPhoneLength = minLength;
    maxPhoneLength = maxLength;
    emit(PhoneInitial(countryCode: newCode));
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
}
