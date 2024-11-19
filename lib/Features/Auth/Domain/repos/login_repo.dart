import 'package:dartz/dartz.dart';
import 'package:tasky/Features/Auth/Domain/Entites/login_entity.dart';

abstract class LoginRepo {
  Future<Either<String, LoginEntity>> loginUser(
      {String? phone, String? password});
}
