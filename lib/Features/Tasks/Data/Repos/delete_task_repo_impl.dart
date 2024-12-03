import 'package:dartz/dartz.dart';
import 'package:tasky/Features/Tasks/Domain/Repos/delete_task_repo.dart';
import 'package:tasky/core/Api/api_consumer.dart';
import 'package:tasky/core/Errors/exceptions.dart';

import '../../../../core/Api/end_points.dart';

class DeleteTaskRepoImpl extends DeleteTaskRepo {
  final ApiConsumer apiConsumer;

  DeleteTaskRepoImpl({required this.apiConsumer});
  @override
  Future<Either<String, String>> deleteTask({required String id}) async {
    try {
      final response =
          await apiConsumer.delete('${EndPoints.getTaskDetails}$id');
      return right('Task deleted successfully');
    } on ServerException catch (e) {
      return left(e.errorModel.message);
    }
  }
}
