import 'package:dartz/dartz.dart';
import 'package:tasky/Features/Tasks/Domain/Repos/edit_task_repo.dart';
import 'package:tasky/core/Api/api_consumer.dart';
import 'package:tasky/core/Api/end_points.dart';
import 'package:tasky/core/Errors/exceptions.dart';

class EditTaskRepoImpl extends EditTaskRepo {
  final ApiConsumer apiConsumer;

  EditTaskRepoImpl({required this.apiConsumer});
  @override
  Future<Either<String, String>> editTask(
      {required String id, required Map<String, dynamic> taskDetais}) async {
    try {
      final response = await apiConsumer.put('${EndPoints.getTaskDetails}$id',
          data: taskDetais);
      return right('Edited successfully');
    } on ServerException catch (e) {
      return left(e.errorModel.message);
    }
  }
}
