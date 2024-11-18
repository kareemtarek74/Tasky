import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/Features/Auth/Data/Models/register_model.dart';
import 'package:tasky/Features/Auth/Domain/Entites/register_entity.dart';
import 'package:tasky/Features/Auth/Domain/repos/register_repo.dart';
import 'package:tasky/core/Api/api_consumer.dart';
import 'package:tasky/core/Api/end_points.dart';
import 'package:tasky/core/Errors/exceptions.dart';

class RegisterRepoImpl extends RegisterRepo {
  final ApiConsumer apiConsumer;
  final SharedPreferences preferences;

  RegisterRepoImpl({required this.preferences, required this.apiConsumer});
  @override
  Future<Either<String, RegisterEntity>> registerUser(
      {String? name,
      String? phone,
      String? password,
      num? yearsOfExperience,
      String? experienceLevel,
      String? address}) async {
    try {
      final response = await apiConsumer.post(
        EndPoints.register,
        data: {
          ApiKeys.phone: phone,
          ApiKeys.password: password,
          ApiKeys.experience: yearsOfExperience,
          ApiKeys.address: address,
          ApiKeys.level: experienceLevel,
        },
      );
      await preferences.setString(
        ApiKeys.accessToken,
        response[ApiKeys.accessToken],
      );
      await preferences.setString(
        ApiKeys.refreshToken,
        response[ApiKeys.refreshToken],
      );
      return right(RegisterModel.fromJson(response));
    } on ServerException catch (e) {
      return left(e.errorModel.message);
    }
  }
}
