import 'package:dartz/dartz.dart';
import 'package:tasky/Features/Tasks/Data/models/create_task_model.dart';
import 'package:tasky/Features/Tasks/Domain/Entities/create_task_entity.dart';
import 'package:tasky/Features/Tasks/Domain/Repos/get_task_details_repo.dart';
import 'package:tasky/core/Api/api_consumer.dart';
import 'package:tasky/core/Api/end_points.dart';
import 'package:tasky/core/Errors/exceptions.dart';

class GetTaskDetailsRepoImpl extends GetTaskDetailsRepo {
  final ApiConsumer apiConsumer;

  GetTaskDetailsRepoImpl({required this.apiConsumer});
  @override
  Future<Either<String, CreateTaskEntity>> getTaskDetails(
      {required String id}) async {
    try {
      final response = await apiConsumer.get('${EndPoints.getTaskDetails}$id');
      return right(CreateTaskModel.fromJson(response));
    } on ServerException catch (e) {
      return left(e.errorModel.message);
    }
  }
}
