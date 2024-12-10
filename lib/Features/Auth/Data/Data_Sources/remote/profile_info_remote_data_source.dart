import 'package:tasky/Features/Auth/Data/Models/profile_info_model.dart';
import 'package:tasky/Features/Auth/Domain/Entites/profile_info_entity.dart';
import 'package:tasky/core/Api/api_consumer.dart';
import 'package:tasky/core/Api/end_points.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileInfoEntity> profileInfoRemote();
}

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  final ApiConsumer apiConsumer;

  ProfileRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<ProfileInfoEntity> profileInfoRemote() async {
    final response = await apiConsumer.get(
      EndPoints.getProfile,
    );
    return ProfileInfoModel.fromJson(response);
  }
}
