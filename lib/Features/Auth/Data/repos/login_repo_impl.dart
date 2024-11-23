import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/Features/Auth/Data/Models/login_model.dart';
import 'package:tasky/Features/Auth/Domain/Entites/login_entity.dart';
import 'package:tasky/Features/Auth/Domain/repos/login_repo.dart';
import 'package:tasky/core/Api/api_consumer.dart';
import 'package:tasky/core/Api/end_points.dart';
import 'package:tasky/core/Errors/exceptions.dart';

class LoginRepoImpl extends LoginRepo {
  final ApiConsumer apiConsumer;
  final SharedPreferences sharedPreferences;

  LoginRepoImpl({required this.apiConsumer, required this.sharedPreferences});

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

      if (!response.containsKey(ApiKeys.accessToken) ||
          !response.containsKey(ApiKeys.refreshToken)) {
        if (response.containsKey('message')) {
          return left(response['message']);
        }
        return left('Invalid login response: Missing tokens.');
      }

      final accessToken = response[ApiKeys.accessToken];
      final refreshToken = response[ApiKeys.refreshToken];

      await sharedPreferences.setString(ApiKeys.accessToken, accessToken);
      await sharedPreferences.setString(ApiKeys.refreshToken, refreshToken);

      return right(LoginModel.fromJson(response));
    } on ServerException catch (e) {
      return left(e.errorModel.message);
    } catch (e) {
      return left('Unexpected error occurred during login.');
    }
  }
}
