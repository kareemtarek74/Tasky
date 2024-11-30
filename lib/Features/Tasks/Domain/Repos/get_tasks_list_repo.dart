import 'package:dartz/dartz.dart';
import 'package:tasky/Features/Tasks/Domain/Entities/create_task_entity.dart';

abstract class GetTasksListRepo {
  Future<Either<String, List<CreateTaskEntity>>> getTasksList();
}
