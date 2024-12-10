import 'package:dartz/dartz.dart';
import 'package:tasky/Features/Auth/Data/Data_Sources/remote/profile_info_remote_data_source.dart';
import 'package:tasky/Features/Auth/Domain/Entites/profile_info_entity.dart';
import 'package:tasky/Features/Auth/Domain/repos/profile_info_repo.dart';
import 'package:tasky/core/Errors/exceptions.dart';

class ProfileInfoRepoImpl extends ProfileInfoRepo {
  final ProfileRemoteDataSource profileRemoteDataSource;

  ProfileInfoRepoImpl({required this.profileRemoteDataSource});
  @override
  Future<Either<String, ProfileInfoEntity>> getProfileInfo() async {
    try {
      final response = await profileRemoteDataSource.profileInfoRemote();

      return right(response);
    } on ServerException catch (e) {
      return left(e.errorModel.message);
    }
  }
}
