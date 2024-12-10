import 'package:dartz/dartz.dart';
import 'package:tasky/Features/Tasks/Domain/Entities/create_task_entity.dart';
import 'package:tasky/Features/Tasks/Domain/Repos/get_tasks_list_repo.dart';
import 'package:tasky/core/UseCase/app_usecases.dart';

class GetTasksListUsecase extends UseCase<List<CreateTaskEntity>, int> {
  final GetTasksListRepo getTasksListRepo;

  GetTasksListUsecase({
    required this.getTasksListRepo,
  });
  @override
  Future<Either<String, List<CreateTaskEntity>>> call(int param) {
    return getTasksListRepo.getTasksList(page: param);
  }
}
