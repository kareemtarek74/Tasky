import 'package:dartz/dartz.dart';
import 'package:tasky/Features/Auth/Domain/Entites/profile_info_entity.dart';

abstract class ProfileInfoRepo {
  Future<Either<String, ProfileInfoEntity>> getProfileInfo();
}
