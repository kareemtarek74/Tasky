import 'package:dartz/dartz.dart';
import 'package:tasky/Features/Tasks/Data/models/create_task_model.dart';
import 'package:tasky/Features/Tasks/Domain/Entities/create_task_entity.dart';
import 'package:tasky/Features/Tasks/Domain/Repos/create_task_repo.dart';
import 'package:tasky/core/Api/api_consumer.dart';
import 'package:tasky/core/Api/end_points.dart';
import 'package:tasky/core/Errors/exceptions.dart';

class CreateTaskRepoImpl extends CreateTaskRepo {
  final ApiConsumer apiConsumer;

  CreateTaskRepoImpl({required this.apiConsumer});
  @override
  Future<Either<String, CreateTaskEntity>> createTask(
      {String? image,
      String? title,
      String? description,
      String? priority,
      String? dueDate}) async {
    try {
      final response = await apiConsumer.post(EndPoints.createTask, data: {
        ApiKeys.image: image,
        ApiKeys.title: title,
        ApiKeys.description: description,
        ApiKeys.priority: priority,
        ApiKeys.date: dueDate
      });
      return right(CreateTaskModel.fromJson(response));
    } on ServerException catch (e) {
      return left(e.errorModel.message);
    }
  }
}
