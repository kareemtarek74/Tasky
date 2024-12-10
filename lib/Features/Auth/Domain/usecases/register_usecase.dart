import 'package:dartz/dartz.dart';
import 'package:tasky/Features/Auth/Domain/Entites/register_entity.dart';
import 'package:tasky/Features/Auth/Domain/repos/register_repo.dart';
import 'package:tasky/core/UseCase/app_usecases.dart';

class RegisterUsecase extends UseCase<RegisterEntity, RegisterParams> {
  final RegisterRepo registerRepo;
  RegisterUsecase({
    required this.registerRepo,
  });
  @override
  Future<Either<String, RegisterEntity>> call(RegisterParams param) {
    return registerRepo.registerUser(
        name: param.displayName,
        password: param.password,
        phone: param.phone,
        address: param.address,
        experienceLevel: param.level,
        yearsOfExperience: param.experienceYears);
  }
}
