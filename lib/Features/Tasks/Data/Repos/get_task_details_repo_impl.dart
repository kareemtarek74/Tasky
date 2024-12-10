import 'package:dartz/dartz.dart';
import 'package:tasky/Features/Tasks/Data/Data_Sources/Remote/get_task_details_remote_data_source.dart';
import 'package:tasky/Features/Tasks/Domain/Entities/create_task_entity.dart';
import 'package:tasky/Features/Tasks/Domain/Repos/get_task_details_repo.dart';
import 'package:tasky/core/Errors/exceptions.dart';

class GetTaskDetailsRepoImpl extends GetTaskDetailsRepo {
  final GetTaskDetailsRemoteDataSource getTaskDetailsRemoteDataSource;

  GetTaskDetailsRepoImpl({required this.getTaskDetailsRemoteDataSource});
  @override
  Future<Either<String, CreateTaskEntity>> getTaskDetails(
      {required String id}) async {
    try {
      final response =
          await getTaskDetailsRemoteDataSource.getTaskDetails(id: id);
      return right(response);
    } on ServerException catch (e) {
      return left(e.errorModel.message);
    }
  }
}
