import 'package:dartz/dartz.dart';
import 'package:tasky/Features/Auth/Domain/Entites/refresh_token_entity.dart';

abstract class RefreshTokenRepo {
  Future<Either<String, RefreshTokenEntity>> refreshToken();
}
