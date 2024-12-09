import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/add_task_view_body.dart';
import 'package:tasky/core/services/get_it_service.dart';

import 'view_model/Task_cubit/task_cubit.dart';

class AddTaskView extends StatelessWidget {
  const AddTaskView({super.key});
  static const String routeName = 'AddTask';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TaskCubit>(),
      child: const AddTaskViewBody(),
    );
  }
}
