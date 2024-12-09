import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/Features/Tasks/presentation/view/view_model/Task_cubit/task_cubit.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/edit_task_view_body.dart';
import 'package:tasky/core/services/get_it_service.dart';

class EditTaskView extends StatelessWidget {
  const EditTaskView({super.key, required this.id});
  static const String routeName = 'editTask';
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TaskCubit>()..getTaskDetails(iD: id),
      child: EditTaskViewBody(
        id: id,
      ),
    );
  }
}
