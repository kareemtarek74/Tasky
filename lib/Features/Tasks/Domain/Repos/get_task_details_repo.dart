import 'package:dartz/dartz.dart';
import 'package:tasky/Features/Tasks/Domain/Entities/create_task_entity.dart';

abstract class GetTaskDetailsRepo {
  Future<Either<String, CreateTaskEntity>> getTaskDetails({required String id});
}
