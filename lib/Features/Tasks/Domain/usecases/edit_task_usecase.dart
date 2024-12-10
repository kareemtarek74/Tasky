import 'package:dartz/dartz.dart';
import 'package:tasky/Features/Tasks/Domain/Repos/edit_task_repo.dart';
import 'package:tasky/core/UseCase/app_usecases.dart';

class EditTaskUsecase extends UseCase<String, EditTaskParams> {
  final EditTaskRepo editTaskRepo;
  EditTaskUsecase({
    required this.editTaskRepo,
  });
  @override
  Future<Either<String, String>> call(EditTaskParams param) {
    return editTaskRepo.editTask(id: param.id, taskDetais: param.data);
  }
}
