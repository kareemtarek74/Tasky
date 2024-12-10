import 'package:dartz/dartz.dart';
import 'package:tasky/Features/Auth/Domain/repos/logout_repo.dart';
import 'package:tasky/core/UseCase/app_usecases.dart';

class UserLogoutUsecase extends UseCase<String, NoParam> {
  final LogoutRepo logoutRepo;
  UserLogoutUsecase({
    required this.logoutRepo,
  });

  @override
  Future<Either<String, String>> call(NoParam param) {
    return logoutRepo.logoutUser();
  }
}
