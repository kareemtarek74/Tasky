import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/task_details_view_body.dart';
import 'package:tasky/core/services/get_it_service.dart';

import '../view_model/Task_cubit/task_cubit.dart';

class TaskDetailsView extends StatelessWidget {
  const TaskDetailsView({super.key, required this.id});
  final String id;
  static const String routeName = 'taskDetails';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TaskCubit>(),
      child: TaskDetailsViewBody(
        iD: id,
      ),
    );
  }
}
