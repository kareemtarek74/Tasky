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

class TaskDueDateUpdated extends TaskState {
  final String dueDate;

  const TaskDueDateUpdated({required this.dueDate});

  @override
  List<Object> get props => [dueDate];
}

class TaskImageUpdated extends TaskState {
  final String? imagePath;

  const TaskImageUpdated({required this.imagePath});
}
