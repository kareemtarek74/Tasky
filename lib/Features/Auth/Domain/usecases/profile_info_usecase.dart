import 'package:dartz/dartz.dart';
import 'package:tasky/Features/Auth/Domain/Entites/profile_info_entity.dart';
import 'package:tasky/Features/Auth/Domain/repos/profile_info_repo.dart';
import 'package:tasky/core/UseCase/app_usecases.dart';

class ProfileInfoUsecase extends UseCase<ProfileInfoEntity, NoParam> {
  final ProfileInfoRepo profileInfoRepo;

  ProfileInfoUsecase({required this.profileInfoRepo});
  @override
  Future<Either<String, ProfileInfoEntity>> call(NoParam param) {
    return profileInfoRepo.getProfileInfo();
  }
}
