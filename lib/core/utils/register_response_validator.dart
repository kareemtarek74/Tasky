import 'package:dartz/dartz.dart';
import 'package:tasky/core/Api/end_points.dart';

class RegisterResponseValidator {
  static Either<String, Map<String, dynamic>> validateResponse(
      Map<String, dynamic> response) {
    if (response.containsKey(ApiKeys.message)) {
      final errorMessage =
          response[ApiKeys.message] ?? 'Unknown error occurred';
      return left(errorMessage);
    }

    final accessToken = response[ApiKeys.accessToken];
    final refreshToken = response[ApiKeys.refreshToken];

    if (accessToken == null || refreshToken == null) {
      return left('Invalid registration response: Missing tokens.');
    }

    return right(response);
  }
}
