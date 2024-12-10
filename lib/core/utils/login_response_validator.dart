import 'package:dartz/dartz.dart';
import 'package:tasky/core/Api/end_points.dart';

class LoginResponseValidator {
  static Either<String, Map<String, dynamic>> validateResponse(
      Map<String, dynamic> response) {
    if (!response.containsKey(ApiKeys.accessToken) ||
        !response.containsKey(ApiKeys.refreshToken)) {
      if (response.containsKey(ApiKeys.message)) {
        return left(response[ApiKeys.message]);
      }
      return left('Invalid login response: Missing tokens.');
    }
    return right(response);
  }
}
