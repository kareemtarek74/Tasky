import 'package:dartz/dartz.dart';
import 'package:tasky/Features/Auth/Data/Models/profile_info_model.dart';
import 'package:tasky/Features/Auth/Domain/Entites/profile_info_entity.dart';
import 'package:tasky/Features/Auth/Domain/repos/profile_info_repo.dart';
import 'package:tasky/core/Api/api_consumer.dart';
import 'package:tasky/core/Api/end_points.dart';
import 'package:tasky/core/Errors/exceptions.dart';

class ProfileInfoRepoImpl extends ProfileInfoRepo {
  final ApiConsumer apiConsumer;

  ProfileInfoRepoImpl({required this.apiConsumer});
  @override
  Future<Either<String, ProfileInfoEntity>> getProfileInfo() async {
    try {
      final response = await apiConsumer.get(EndPoints.getProfile);

      return right(ProfileInfoModel.fromJson(response));
    } on ServerException catch (e) {
      return left(e.errorModel.message);
    }
  }
}
