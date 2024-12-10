import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tasky/Features/Tasks/presentation/view/view_model/Task_cubit/task_cubit.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/status_selector_drop_down.dart';
import 'package:tasky/core/text_styles.dart';
import 'package:tasky/core/widgets/custom_app_bar.dart';
import 'package:tasky/core/widgets/custom_button.dart';
import 'package:tasky/core/widgets/custom_error%20_snack_bar.dart';
import 'package:tasky/core/widgets/custom_progress_indicator.dart';

import 'task_helpers.dart';

class EditTaskViewBody extends StatelessWidget {
  const EditTaskViewBody({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is EditTaskSuccessState) {
          navigateToHome(context);
        } else if (state is UploadImageErrorState ||
            state is EditTaskErrorState) {
          CustomSnackbar.showError(
              context: context, message: 'There is an error, please try again');
        }
      },
      builder: (context, state) {
        final taskCubit = BlocProvider.of<TaskCubit>(context);
        return ModalProgressHUD(
          inAsyncCall: state is UploadImageLoadingState ||
              state is EditTaskLoadingState ||
              state is GetTasksListLoadingState,
          progressIndicator: const CustomProgressIndicator(),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: taskCubit.editTaskFormKey,
                  autovalidateMode: taskCubit.autovalidateMode,
                  child: Column(
                    children: [
                      const CustomAppBar(title: 'Edit your task'),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: Column(
                          children: [
                            buildImageSelector(taskCubit),
                            const SizedBox(height: 16),
                            buildTextField(
                              controller: taskCubit.editTitleController,
                              label: 'Change task title',
                              hintText: 'Change title here...',
                            ),
                            const SizedBox(height: 16),
                            buildTextField(
                              controller: taskCubit.editDescriptionController,
                              label: 'Change task Description',
                              hintText: 'Change description here...',
                              maxLines: 5,
                            ),
                            const SizedBox(height: 16),
                            buildPrioritySelector(context),
                            const SizedBox(height: 16),
                            buildStatusSelector(context),
                            const SizedBox(height: 28.5),
                            CustomButton(
                              text: 'Edit task',
                              style: Styles.styleBold19(context),
                              hasIcon: false,
                              onPressed: () async {
                                await onEditTaskPressed(taskCubit);
                              },
                            ),
                            const SizedBox(height: 22),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildStatusSelector(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Change Status',
            style: Styles.styleRegular12(context)
                .copyWith(color: const Color(0xff6E6A7C))),
        const SizedBox(height: 8),
        StateDropdown(id: id),
      ],
    );
  }

  Future<void> onEditTaskPressed(TaskCubit taskCubit) async {
    final isValid = taskCubit.editTaskFormKey.currentState!.validate();
    if (!isValid) {
      taskCubit.updateAutovalidateMode(AutovalidateMode.always);
      return;
    }
    if (taskCubit.image != null && taskCubit.uploadedImage == null) {
      await taskCubit.uploadImage();
    }
    if (taskCubit.uploadedImage != null || taskCubit.image == null) {
      await taskCubit.editTask(id: id, taskDetails: {
        "title": taskCubit.editTitleController.text,
        "desc": taskCubit.editDescriptionController.text,
        "image": taskCubit.uploadedImage,
        "priority": taskCubit.prioritySelected,
        "status": taskCubit.statusSelected,
      });
    }
  }
}
