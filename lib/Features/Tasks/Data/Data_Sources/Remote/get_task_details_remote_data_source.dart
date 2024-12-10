import 'package:tasky/Features/Tasks/Data/models/create_task_model.dart';
import 'package:tasky/Features/Tasks/Domain/Entities/create_task_entity.dart';
import 'package:tasky/core/Api/api_consumer.dart';
import 'package:tasky/core/Api/end_points.dart';

abstract class GetTaskDetailsRemoteDataSource {
  Future<CreateTaskEntity> getTaskDetails({required String id});
}

class GetTaskDetailsRemoteDataSourceImpl
    implements GetTaskDetailsRemoteDataSource {
  final ApiConsumer apiConsumer;

  GetTaskDetailsRemoteDataSourceImpl({
    required this.apiConsumer,
  });

  @override
  Future<CreateTaskEntity> getTaskDetails({required String id}) async {
    final response = await apiConsumer.get(
      '${EndPoints.getTaskDetails}$id',
    );
    return CreateTaskModel.fromJson(response);
  }
}
