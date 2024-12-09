import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/Features/Tasks/presentation/view/view_model/Task_cubit/task_cubit.dart';
import 'package:tasky/core/services/get_it_service.dart';

class TaskCubitProvider extends StatelessWidget {
  final Widget child;

  const TaskCubitProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TaskCubit>()..getTasksList(),
      child: child,
    );
  }
}
