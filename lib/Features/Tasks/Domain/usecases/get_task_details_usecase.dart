import 'package:dartz/dartz.dart';
import 'package:tasky/Features/Tasks/Domain/Entities/create_task_entity.dart';
import 'package:tasky/Features/Tasks/Domain/Repos/get_task_details_repo.dart';
import 'package:tasky/core/UseCase/app_usecases.dart';

class GetTaskDetailsUsecase extends UseCase<CreateTaskEntity, String> {
  final GetTaskDetailsRepo getTaskDetailsRepo;

  GetTaskDetailsUsecase({required this.getTaskDetailsRepo});
  @override
  Future<Either<String, CreateTaskEntity>> call(String param) {
    return getTaskDetailsRepo.getTaskDetails(id: param);
  }
}
