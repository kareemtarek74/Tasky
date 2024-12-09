import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/Features/Tasks/presentation/view/view_model/Task_cubit/task_cubit.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/home_view_body.dart';
import 'package:tasky/core/services/get_it_service.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const String routeName = 'Home';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TaskCubit>()..getTasksList(),
      child: const HomeViewBody(),
    );
  }
}
