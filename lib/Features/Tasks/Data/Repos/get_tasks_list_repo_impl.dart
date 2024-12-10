import 'package:dartz/dartz.dart';
import 'package:tasky/Features/Tasks/Data/models/create_task_model.dart';
import 'package:tasky/Features/Tasks/Domain/Entities/create_task_entity.dart';
import 'package:tasky/Features/Tasks/Domain/Repos/get_tasks_list_repo.dart';
import 'package:tasky/core/Api/api_consumer.dart';
import 'package:tasky/core/Api/end_points.dart';
import 'package:tasky/core/Errors/exceptions.dart';

class GetTasksListRepoImpl extends GetTasksListRepo {
  final ApiConsumer apiConsumer;

  GetTasksListRepoImpl({required this.apiConsumer});

  @override
  Future<Either<String, List<CreateTaskEntity>>> getTasksList(
      {int page = 1}) async {
    try {
      final response =
          await apiConsumer.get('${EndPoints.getTasksList}?page=$page');
      final tasks = TaskMapper.fromJsonList(response);
      return right(tasks);
    } on ServerException catch (e) {
      return left(e.errorModel.message);
    }
  }
}

class TaskMapper {
  static List<CreateTaskEntity> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((task) => CreateTaskModel.fromJson(task)).toList();
  }
}
