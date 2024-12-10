import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/Features/Auth/Data/Models/login_model.dart';
import 'package:tasky/Features/Auth/Domain/Entites/login_entity.dart';
import 'package:tasky/Features/Auth/Domain/repos/login_repo.dart';
import 'package:tasky/core/Api/api_consumer.dart';
import 'package:tasky/core/Api/end_points.dart';
import 'package:tasky/core/Errors/exceptions.dart';
import 'package:tasky/core/utils/login_response_validator.dart';

class LoginRepoImpl extends LoginRepo {
  final ApiConsumer apiConsumer;
  final SharedPreferences sharedPreferences;

  LoginRepoImpl({
    required this.apiConsumer,
    required this.sharedPreferences,
  });

  @override
  Future<Either<String, LoginEntity>> loginUser({
    String? phone,
    String? password,
  }) async {
    try {
      final response = await apiConsumer.post(
        EndPoints.login,
        data: {ApiKeys.phone: phone, ApiKeys.password: password},
      );

      final validationResult =
          LoginResponseValidator.validateResponse(response);

      return validationResult.fold(
        (error) => left(error),
        (validResponse) async {
          final accessToken = validResponse[ApiKeys.accessToken];
          final refreshToken = validResponse[ApiKeys.refreshToken];

          await storeTokens(accessToken, refreshToken);

          return right(LoginModel.fromJson(validResponse));
        },
      );
    } on ServerException catch (e) {
      return left(e.errorModel.message);
    } catch (e) {
      return left('Unexpected error occurred during login.');
    }
  }

  Future<void> storeTokens(String accessToken, String refreshToken) async {
    await sharedPreferences.setString(ApiKeys.accessToken, accessToken);
    await sharedPreferences.setString(ApiKeys.refreshToken, refreshToken);
  }
}
