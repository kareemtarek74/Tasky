part of 'task_cubit.dart';

sealed class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

final class TaskInitial extends TaskState {}

class TaskPriorityUpdated extends TaskState {
  final String selectedPriority;
  final Color flagColor;
  final Color fieldColor;

  const TaskPriorityUpdated({
    required this.selectedPriority,
    required this.flagColor,
    required this.fieldColor,
  });

  @override
  List<Object> get props => [selectedPriority, flagColor, fieldColor];
}

class TaskStatusUpdated extends TaskState {
  final String selectedStatus;
  final Color statusfieldColor;

  const TaskStatusUpdated({
    required this.selectedStatus,
    required this.statusfieldColor,
  });

  @override
  List<Object> get props => [selectedStatus, statusfieldColor];
}

class IndexNumUpdatedSuccessState extends TaskState {
  final int indexnum;

  const IndexNumUpdatedSuccessState({required this.indexnum});
}

class TaskDueDateUpdated extends TaskState {
  final String dueDate;

  const TaskDueDateUpdated({required this.dueDate});

  @override
  List<Object> get props => [dueDate];
}

class TaskImageUpdated extends TaskState {
  final XFile? imagePath;

  const TaskImageUpdated({required this.imagePath});
}

class TaskAutovalidateModeUpdated extends TaskState {
  final AutovalidateMode autovalidateMode;

  const TaskAutovalidateModeUpdated(this.autovalidateMode);
}

class UploadImageLoadingState extends TaskState {}

class UploadImageSuccessState extends TaskState {}

class UploadImageErrorState extends TaskState {
  final String errorMessage;

  const UploadImageErrorState({required this.errorMessage});
}

class TaskFieldsReset extends TaskState {}

class CreateTaskLoadingState extends TaskState {}

class CreateTaskSuccessState extends TaskState {}

class CreateTaskErrorState extends TaskState {
  final String errorMessage;

  const CreateTaskErrorState({required this.errorMessage});
}

class GetTasksListLoadingState extends TaskState {}

class GetTasksListSuccessState extends TaskState {}

class GetTasksListErrorState extends TaskState {
  final String errorMessage;

  const GetTasksListErrorState({required this.errorMessage});
}

class GetTaskDetailsLoadingState extends TaskState {}

class GetTaskDetailsSuccessState extends TaskState {
  final CreateTaskEntity task;

  const GetTaskDetailsSuccessState({required this.task});
}

class GetTaskDetailsErrorState extends TaskState {
  final String errorMessage;

  const GetTaskDetailsErrorState({required this.errorMessage});
}
