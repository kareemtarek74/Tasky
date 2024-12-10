import 'package:dartz/dartz.dart';
import 'package:tasky/Features/Tasks/Domain/Entities/create_task_entity.dart';
import 'package:tasky/Features/Tasks/Domain/Repos/create_task_repo.dart';
import 'package:tasky/core/UseCase/app_usecases.dart';

class CreateTaskUseCase extends UseCase<CreateTaskEntity, CreateTaskParams> {
  final CreateTaskRepo createTaskRepo;

  CreateTaskUseCase({
    required this.createTaskRepo,
  });

  @override
  Future<Either<String, CreateTaskEntity>> call(CreateTaskParams param) {
    return createTaskRepo.createTask(
        title: param.title,
        description: param.desc,
        dueDate: param.dueDate,
        image: param.image,
        priority: param.priority);
  }
}
