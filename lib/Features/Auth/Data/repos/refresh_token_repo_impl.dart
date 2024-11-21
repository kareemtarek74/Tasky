import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/Features/Auth/Data/Models/refresh_token_model.dart';
import 'package:tasky/Features/Auth/Domain/Entites/refresh_token_entity.dart';
import 'package:tasky/Features/Auth/Domain/repos/refresh_token_repo.dart';
import 'package:tasky/core/Api/api_consumer.dart';
import 'package:tasky/core/Api/end_points.dart';
import 'package:tasky/core/Errors/exceptions.dart';

class RefreshTokenRepoImpl extends RefreshTokenRepo {
  final ApiConsumer apiConsumer;
  final SharedPreferences sharedPreferences;

  RefreshTokenRepoImpl(
      {required this.apiConsumer, required this.sharedPreferences});
  @override
  Future<Either<String, RefreshTokenEntity>> refreshToken() async {
    try {
      final response = await apiConsumer.get(EndPoints.refreshToken,
          queryParameters: {
            ApiKeys.token: sharedPreferences.getString(ApiKeys.refreshToken)
          });

      await sharedPreferences.setString(
          ApiKeys.accessToken, response[ApiKeys.accessToken]);
      return right(RefreshTokenModel.fromJson(response));
    } on ServerException catch (e) {
      return left(e.errorModel.message);
    }
  }
}
