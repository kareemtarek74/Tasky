import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/Features/Auth/presentation/views/widgets/custom_error_widget.dart';
import 'package:tasky/Features/Tasks/presentation/view/view_model/Task_cubit/task_cubit.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/custom_task_details_body.dart';
import 'package:tasky/core/widgets/custom_app_bar.dart';
import 'package:tasky/core/widgets/custom_progress_indicator.dart';

class TaskDetailsViewBody extends StatelessWidget {
  const TaskDetailsViewBody({super.key, required this.iD});
  final String iD;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomAppBar(
                title: 'Task Details',
                hasIcon: true,
                padding: EdgeInsets.only(top: 12, left: 22, right: 10),
              ),
              BlocBuilder<TaskCubit, TaskState>(
                builder: (context, state) {
                  if (state is GetTaskDetailsLoadingState) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: const Center(
                        child: CustomProgressIndicator(),
                      ),
                    );
                  } else if (state is GetTaskDetailsErrorState) {
                    return CustomErrorWidget(
                      errorMessage: state.errorMessage,
                      onRetry: () {
                        BlocProvider.of<TaskCubit>(context)
                            .getTaskDetails(iD: iD);
                      },
                    );
                  } else if (state is GetTaskDetailsSuccessState) {
                    return CustomTaskDetailsBody(
                      task: state.task,
                    );
                  } else {
                    return CustomErrorWidget(
                      errorMessage: 'There was an error, please try again',
                      onRetry: () {
                        BlocProvider.of<TaskCubit>(context)
                            .getTaskDetails(iD: iD);
                      },
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
