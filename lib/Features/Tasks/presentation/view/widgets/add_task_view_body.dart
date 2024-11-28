import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tasky/Features/Tasks/presentation/view/view_model/Task_cubit/task_cubit.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/add_image_dotted_button.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/date_picker.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/priority_selector_dropdown.dart';
import 'package:tasky/core/text_styles.dart';
import 'package:tasky/core/widgets/custom_app_bar.dart';
import 'package:tasky/core/widgets/custom_button.dart';
import 'package:tasky/core/widgets/custom_error%20_snack_bar.dart';
import 'package:tasky/core/widgets/custom_progress_indicator.dart';

import 'custom_task_text_field.dart';

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
        } else if (state is UploadImageErrorState) {
          CustomSnackbar.showError(
              context: context, message: state.errorMessage);
        }
      },
      builder: (context, state) {
        final taskCubit = BlocProvider.of<TaskCubit>(context);
        return ModalProgressHUD(
          inAsyncCall: state is UploadImageLoadingState ||
                  state is CreateTaskLoadingState
              ? true
              : false,
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
                      const SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: Column(
                          children: [
                            taskCubit.image == null
                                ? AddImageButton(
                                    onImageSelected: (image) {
                                      setState(() {
                                        taskCubit.saveImagePath(image);
                                      });
                                    },
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        taskCubit.saveImagePath(null);
                                      });
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.file(
                                        File(taskCubit.image!.path),
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 300,
                                      ),
                                    ),
                                  ),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTaskTextField(
                                autovalidateMode: taskCubit.autovalidateMode,
                                controller: taskCubit.titleController,
                                label: 'Task title',
                                hintText: 'Enter title here...'),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTaskTextField(
                              autovalidateMode: taskCubit.autovalidateMode,
                              controller: taskCubit.descriptionController,
                              label: 'Task Description',
                              hintText: 'Enter description here...',
                              maxLines: 5,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Priority',
                                    style: Styles.styleRegular12(context)
                                        .copyWith(
                                            color: const Color(0xff6E6A7C))),
                                const SizedBox(height: 8),
                                const PriorityDropdown(),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Due date',
                                    style: Styles.styleRegular12(context)
                                        .copyWith(
                                            color: const Color(0xff6E6A7C))),
                                const SizedBox(height: 8),
                                const DueDatePicker(),
                              ],
                            ),
                            const SizedBox(height: 28.5),
                            CustomButton(
                              text: 'Add task',
                              style: Styles.styleBold19(context),
                              hasIcon: false,
                              onPressed: () async {
                                final taskCubit =
                                    BlocProvider.of<TaskCubit>(context);
                                final isValid = taskCubit
                                    .createTaskFormKey.currentState!
                                    .validate();
                                if (!isValid) {
                                  taskCubit.updateAutovalidateMode(
                                      AutovalidateMode.always);
                                  return;
                                }
                                if (isValid &&
                                    taskCubit.image == null &&
                                    taskCubit.uploadedImage == null) {
                                  CustomSnackbar.showError(
                                    context: context,
                                    message: 'Please upload an image first',
                                  );
                                  return;
                                }
                                if (isValid &&
                                    taskCubit.image != null &&
                                    taskCubit.uploadedImage == null) {
                                  await taskCubit.uploadImage();
                                  if (isValid &&
                                      taskCubit.uploadedImage == null) {
                                    CustomSnackbar.showError(
                                      context: context,
                                      message:
                                          'Image upload failed. Please try again.',
                                    );
                                    return;
                                  }
                                }
                                if (isValid &&
                                    taskCubit.uploadedImage != null) {
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
