import 'package:dartz/dartz.dart';
import 'package:tasky/Features/Auth/Domain/Entites/register_entity.dart';

abstract class RegisterRepo {
  Future<Either<String, RegisterEntity>> registerUser(
      {String? name,
      String? phone,
      String? password,
      num? yearsOfExperience,
      String? experienceLevel,
      String? address});
}
