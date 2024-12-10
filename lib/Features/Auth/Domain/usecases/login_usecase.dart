import 'package:dartz/dartz.dart';
import 'package:tasky/Features/Auth/Domain/repos/login_repo.dart';
import 'package:tasky/core/UseCase/app_usecases.dart';

import '../Entites/login_entity.dart';

class LoginUsecase extends UseCase<LoginEntity, LoginParams> {
  final LoginRepo loginRepo;

  LoginUsecase({required this.loginRepo});

  @override
  Future<Either<String, LoginEntity>> call(param) {
    return loginRepo.loginUser(phone: param.phone, password: param.password);
  }
}
