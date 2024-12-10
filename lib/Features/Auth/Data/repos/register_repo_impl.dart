import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/Features/Auth/Data/Models/register_model.dart';
import 'package:tasky/Features/Auth/Domain/Entites/register_entity.dart';
import 'package:tasky/Features/Auth/Domain/repos/register_repo.dart';
import 'package:tasky/core/Api/api_consumer.dart';
import 'package:tasky/core/Api/end_points.dart';
import 'package:tasky/core/Errors/exceptions.dart';
import 'package:tasky/core/utils/register_response_validator.dart';

class RegisterRepoImpl extends RegisterRepo {
  final ApiConsumer apiConsumer;
  final SharedPreferences preferences;

  RegisterRepoImpl({
    required this.preferences,
    required this.apiConsumer,
  });

  @override
  Future<Either<String, RegisterEntity>> registerUser({
    String? name,
    String? phone,
    String? password,
    num? yearsOfExperience,
    String? experienceLevel,
    String? address,
  }) async {
    try {
      final response = await apiConsumer.post(
        EndPoints.register,
        data: {
          ApiKeys.name: name,
          ApiKeys.phone: phone,
          ApiKeys.password: password,
          ApiKeys.experience: yearsOfExperience,
          ApiKeys.address: address,
          ApiKeys.level: experienceLevel,
        },
      );

      final validationResult =
          RegisterResponseValidator.validateResponse(response);
      return validationResult.fold(
        (error) => left(error),
        (validResponse) async {
          final accessToken = validResponse[ApiKeys.accessToken];
          final refreshToken = validResponse[ApiKeys.refreshToken];

          await preferences.setString(ApiKeys.accessToken, accessToken);
          await preferences.setString(ApiKeys.refreshToken, refreshToken);

          return right(RegisterModel.fromJson(validResponse));
        },
      );
    } on ServerException catch (e) {
      return left(e.errorModel.message);
    }
  }
}
