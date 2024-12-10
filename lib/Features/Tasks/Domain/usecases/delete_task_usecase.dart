import 'package:dartz/dartz.dart';
import 'package:tasky/Features/Tasks/Domain/Repos/delete_task_repo.dart';
import 'package:tasky/core/UseCase/app_usecases.dart';

class DeleteTaskUsecase extends UseCase<String, String> {
  final DeleteTaskRepo deleteTaskRepo;

  DeleteTaskUsecase({required this.deleteTaskRepo});

  @override
  Future<Either<String, String>> call(String param) {
    return deleteTaskRepo.deleteTask(id: param);
  }
}
