import 'package:tasky/Features/Tasks/Data/models/create_task_model.dart';
import 'package:tasky/Features/Tasks/Domain/Entities/create_task_entity.dart';
import 'package:tasky/core/Api/api_consumer.dart';
import 'package:tasky/core/Api/end_points.dart';

abstract class GetTasksListRemoteDataSource {
  Future<List<CreateTaskEntity>> getTasksList({required int page});
}

class GetTasksListRemoteDataSourceImpl implements GetTasksListRemoteDataSource {
  final ApiConsumer apiConsumer;

  GetTasksListRemoteDataSourceImpl({
    required this.apiConsumer,
  });

  @override
  Future<List<CreateTaskEntity>> getTasksList({required int page}) async {
    final List response = await apiConsumer.get(
      '${EndPoints.getTasksList}?page=$page',
    );
    List<CreateTaskEntity> responseModel = [];
    for (var element in response) {
      var model = CreateTaskModel.fromJson(element);
      responseModel.add(model);
    }
    return responseModel;
  }
}
