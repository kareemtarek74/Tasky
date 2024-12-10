import 'package:dartz/dartz.dart';
import 'package:tasky/Features/Auth/Domain/Entites/refresh_token_entity.dart';
import 'package:tasky/Features/Auth/Domain/repos/refresh_token_repo.dart';
import 'package:tasky/core/UseCase/app_usecases.dart';

class RefreshTokenUsecase extends UseCase<RefreshTokenEntity, NoParam> {
  final RefreshTokenRepo refreshTokenRepo;

  RefreshTokenUsecase({required this.refreshTokenRepo});

  @override
  Future<Either<String, RefreshTokenEntity>> call(NoParam param) {
    return refreshTokenRepo.refreshToken();
  }
}
