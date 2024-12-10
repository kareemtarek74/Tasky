import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tasky/Features/Tasks/presentation/view/home_view.dart';
import 'package:tasky/Features/Tasks/presentation/view/view_model/Task_cubit/task_cubit.dart';
import 'package:tasky/core/text_styles.dart';
import 'package:tasky/core/widgets/custom_app_bar.dart';
import 'package:tasky/core/widgets/custom_button.dart';
import 'package:tasky/core/widgets/custom_error%20_snack_bar.dart';
import 'package:tasky/core/widgets/custom_progress_indicator.dart';

import 'task_helpers.dart';

class AddTaskViewBody extends StatefulWidget {
  const AddTaskViewBody({super.key});

  @override
  State<AddTaskViewBody> createState() => _AddTaskViewBodyState();
}

class _AddTaskViewBodyState extends State<AddTaskViewBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is CreateTaskSuccessState) {
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
              context, HomeView.routeName, (route) => false);
        } else if (state is UploadImageErrorState) {
          CustomSnackbar.showError(
              context: context, message: state.errorMessage);
        }
      },
      builder: (context, state) {
        final taskCubit = BlocProvider.of<TaskCubit>(context);
        return ModalProgressHUD(
          inAsyncCall: state is UploadImageLoadingState ||
              state is CreateTaskLoadingState,
          progressIndicator: const CustomProgressIndicator(),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: taskCubit.createTaskFormKey,
                  autovalidateMode: taskCubit.autovalidateMode,
                  child: Column(
                    children: [
                      const CustomAppBar(title: 'Add new task'),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: Column(
                          children: [
                            buildImageSelector(taskCubit),
                            const SizedBox(height: 16),
                            buildTextField(
                              controller: taskCubit.titleController,
                              label: 'Task title',
                              hintText: 'Enter title here...',
                            ),
                            const SizedBox(height: 16),
                            buildTextField(
                              controller: taskCubit.descriptionController,
                              label: 'Task Description',
                              hintText: 'Enter description here...',
                              maxLines: 5,
                            ),
                            const SizedBox(height: 16),
                            buildPrioritySelector(context),
                            const SizedBox(height: 16),
                            buildDateSelector(context),
                            const SizedBox(height: 28.5),
                            CustomButton(
                              text: 'Add task',
                              style: Styles.styleBold19(context),
                              hasIcon: false,
                              onPressed: () async {
                                final isValid = taskCubit
                                    .createTaskFormKey.currentState!
                                    .validate();
                                if (!isValid) {
                                  taskCubit.updateAutovalidateMode(
                                      AutovalidateMode.always);
                                  return;
                                }
                                if (taskCubit.image == null &&
                                    taskCubit.uploadedImage == null) {
                                  CustomSnackbar.showError(
                                      context: context,
                                      message: 'Please upload an image first');
                                  return;
                                }
                                if (taskCubit.image != null &&
                                    taskCubit.uploadedImage == null) {
                                  await taskCubit.uploadImage();
                                  if (taskCubit.uploadedImage == null) {
                                    CustomSnackbar.showError(
                                        context: context,
                                        message:
                                            'Image upload failed. Please try again.');
                                    return;
                                  }
                                }
                                if (taskCubit.uploadedImage != null) {
                                  await taskCubit.creatTasks();
                                }
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
}
