import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/Features/Tasks/presentation/view/view_model/Task_cubit/task_cubit.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/add_image_dotted_button.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/date_picker.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/priority_selector_dropdown.dart';
import 'package:tasky/core/text_styles.dart';
import 'package:tasky/core/widgets/custom_app_bar.dart';
import 'package:tasky/core/widgets/custom_button.dart';
import 'package:tasky/core/widgets/custom_error%20_snack_bar.dart';
import 'package:tasky/core/widgets/custom_success_snack_bar.dart';

import 'custom_task_text_field.dart';

class AddTaskViewBody extends StatelessWidget {
  const AddTaskViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocConsumer<TaskCubit, TaskState>(
            listener: (context, state) {
              if (state is UploadImageSuccessState) {
                CustomSuccessSnackbar.showSuccess(
                    context: context, message: 'successfully uploaded');
              } else if (state is UploadImageErrorState) {
                CustomSnackbar.showError(
                    context: context, message: state.errorMessage);
              }
            },
            builder: (context, state) {
              final taskCubit = BlocProvider.of<TaskCubit>(context);
              return Column(
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
                                  taskCubit.saveImagePath(image);
                                },
                              )
                            : GestureDetector(
                                onTap: () {
                                  taskCubit.saveImagePath(null);
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
                        const CustomTaskTextField(
                            label: 'Task title',
                            hintText: 'Enter title here...'),
                        const SizedBox(
                          height: 16,
                        ),
                        const CustomTaskTextField(
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
                                    .copyWith(color: const Color(0xff6E6A7C))),
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
                                    .copyWith(color: const Color(0xff6E6A7C))),
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
                              if (taskCubit.image != null) {
                                await taskCubit.uploadImage();
                              }
                            }),
                        const SizedBox(height: 22),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
