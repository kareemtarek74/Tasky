import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/Features/Tasks/Domain/Entities/create_task_entity.dart';
import 'package:tasky/Features/Tasks/presentation/view/view_model/Task_cubit/task_cubit.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/custom_task_item.dart';

class CustomTaskListView extends StatelessWidget {
  final List<CreateTaskEntity> tasks;

  const CustomTaskListView({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<TaskCubit>(context);

    return Expanded(
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
              cubit.hasMoreData &&
              !cubit.isLoadingMore) {
            cubit.getTasksList(loadMore: true);
          }
          return false;
        },
        child: ListView.builder(
          itemCount: tasks.length + (cubit.isLoadingMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < tasks.length) {
              return CustomTaskItem(task: tasks[index]);
            } else {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
