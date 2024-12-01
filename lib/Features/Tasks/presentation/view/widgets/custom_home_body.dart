import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/Features/Auth/presentation/views/widgets/custom_error_widget.dart';
import 'package:tasky/Features/Tasks/presentation/view/add_task_view.dart';
import 'package:tasky/Features/Tasks/presentation/view/view_model/Task_cubit/task_cubit.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/custom_empty_task.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/custom_task_list_view.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/my_tasks_list_view.dart';
import 'package:tasky/core/text_styles.dart';
import 'package:tasky/core/utils/app_colors.dart';
import 'package:tasky/core/widgets/custom_progress_indicator.dart';

class CustomHomeBody extends StatelessWidget {
  const CustomHomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            await BlocProvider.of<TaskCubit>(context).getTasksList();
          },
          color: AppColors.primaryColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  children: [
                    Text(
                      'My Tasks',
                      style: Styles.styleBold16(context).copyWith(
                        color: const Color(0x9924252C),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const FittedBox(fit: BoxFit.scaleDown, child: MyTasksListView()),
              const SizedBox(height: 16),
              BlocBuilder<TaskCubit, TaskState>(
                builder: (context, state) {
                  final cubit = BlocProvider.of<TaskCubit>(context);
                  final tasksList = cubit.indexNumSelected == 0
                      ? cubit.allTasks
                      : cubit.indexNumSelected == 1
                          ? cubit.inPogress
                          : cubit.indexNumSelected == 2
                              ? cubit.waiting
                              : cubit.finished;
                  if (state is GetTasksListLoadingState) {
                    return const Expanded(
                      child: Center(child: CustomProgressIndicator()),
                    );
                  } else if (tasksList.isNotEmpty) {
                    return CustomTaskListView(tasks: tasksList);
                  } else if (state is GetTasksListErrorState) {
                    return Expanded(
                      child: CustomErrorWidget(
                        errorMessage: 'There is a problem, please try again',
                        onRetry: () {
                          cubit.getTasksList();
                        },
                      ),
                    );
                  } else {
                    return Expanded(
                      child: CustomEmptyListWidget(
                        message:
                            'No tasks available here. Start by adding a new task!',
                        onAdd: () {
                          Navigator.pushNamed(context, AddTaskView.routeName);
                        },
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
