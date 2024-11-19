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
  Future<Either<String, LoginEntity>> loginUser(
      {String? phone, String? password}) async {
    try {
      final response = await apiConsumer.post(
        EndPoints.login,
        data: {ApiKeys.phone: phone, ApiKeys.password: password},
      );

      await sharedPreferences.setString(
          ApiKeys.accessToken, response[ApiKeys.accessToken]);
      await sharedPreferences.setString(
          ApiKeys.refreshToken, response[ApiKeys.refreshToken]);
      return right(LoginModel.fromJson(response));
    } on ServerException catch (e) {
      return left(e.errorModel.message);
    }
  }
}
