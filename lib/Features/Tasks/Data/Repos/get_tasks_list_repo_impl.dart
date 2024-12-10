import 'package:dartz/dartz.dart';
import 'package:tasky/Features/Tasks/Data/Data_Sources/Remote/get_tasks_list_remote_data_source.dart';
import 'package:tasky/Features/Tasks/Domain/Entities/create_task_entity.dart';
import 'package:tasky/Features/Tasks/Domain/Repos/get_tasks_list_repo.dart';
import 'package:tasky/core/Errors/exceptions.dart';

class GetTasksListRepoImpl extends GetTasksListRepo {
  final GetTasksListRemoteDataSource getTasksListRemoteDataSource;

  GetTasksListRepoImpl({required this.getTasksListRemoteDataSource});

  @override
  Future<Either<String, List<CreateTaskEntity>>> getTasksList(
      {int page = 1}) async {
    try {
      final response =
          await getTasksListRemoteDataSource.getTasksList(page: page);

      return right(response);
    } on ServerException catch (e) {
      return left(e.errorModel.message);
    }
  }
}
