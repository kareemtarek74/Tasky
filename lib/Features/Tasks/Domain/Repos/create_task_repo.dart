import 'package:dartz/dartz.dart';
import 'package:tasky/Features/Tasks/Domain/Entities/create_task_entity.dart';

abstract class CreateTaskRepo {
  Future<Either<String, CreateTaskEntity>> createTask(
      {String? image,
      String? title,
      String? description,
      String? priority,
      String? dueDate});
}
