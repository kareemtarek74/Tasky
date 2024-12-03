import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tasky/Features/Auth/presentation/views/widgets/custom_error_widget.dart';
import 'package:tasky/Features/Tasks/presentation/view/view_model/Task_cubit/task_cubit.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/custom_task_details_body.dart';
import 'package:tasky/core/widgets/custom_app_bar.dart';
import 'package:tasky/core/widgets/custom_progress_indicator.dart';

class TaskDetailsViewBody extends StatefulWidget {
  const TaskDetailsViewBody({super.key, required this.iD});
  final String iD;

  @override
  State<TaskDetailsViewBody> createState() => _TaskDetailsViewBodyState();
}

class _TaskDetailsViewBodyState extends State<TaskDetailsViewBody> {
  bool isDataLoaded = false;

  @override
  void initState() {
    super.initState();
    if (!isDataLoaded) {
      BlocProvider.of<TaskCubit>(context).getTaskDetails(iD: widget.iD);
      isDataLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(
                id: widget.iD,
                title: 'Task Details',
                hasIcon: true,
                padding: const EdgeInsets.only(top: 12, left: 22, right: 10),
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
                            .getTaskDetails(iD: widget.iD);
                      },
                    );
                  } else if (state is GetTaskDetailsSuccessState) {
                    return Column(
                      children: [
                        CustomTaskDetailsBody(
                          task: state.task,
                        ),
                        const SizedBox(height: 20),
                        QrImageView(
                          data: "task/${widget.iD}",
                          version: QrVersions.auto,
                          size: 300,
                        ),
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    );
                  }
                  return CustomErrorWidget(
                    errorMessage: 'There was an error, please try again',
                    onRetry: () {
                      BlocProvider.of<TaskCubit>(context)
                          .getTaskDetails(iD: widget.iD);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
