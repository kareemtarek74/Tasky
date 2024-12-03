import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tasky/Features/Tasks/presentation/view/home_view.dart';
import 'package:tasky/Features/Tasks/presentation/view/view_model/Task_cubit/task_cubit.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/add_image_dotted_button.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/priority_selector_dropdown.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/status_selector_drop_down.dart';
import 'package:tasky/core/text_styles.dart';
import 'package:tasky/core/widgets/custom_app_bar.dart';
import 'package:tasky/core/widgets/custom_button.dart';
import 'package:tasky/core/widgets/custom_error%20_snack_bar.dart';
import 'package:tasky/core/widgets/custom_progress_indicator.dart';

import 'custom_task_text_field.dart';

class EditTaskViewBody extends StatefulWidget {
  const EditTaskViewBody({super.key, required this.id});
  final String id;

  @override
  State<EditTaskViewBody> createState() => _EditTaskViewBodyState();
}

class _EditTaskViewBodyState extends State<EditTaskViewBody> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) async {
        if (state is EditTaskSuccessState) {
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(
              context, HomeView.routeName, (route) => false);
          await BlocProvider.of<TaskCubit>(context).getTasksList();
        } else if (state is UploadImageErrorState) {
          CustomSnackbar.showError(
              context: context, message: state.errorMessage);
        } else if (state is EditTaskErrorState) {
          CustomSnackbar.showError(
              context: context, message: state.errorMessage);
        }
      },
      builder: (context, state) {
        final taskCubit = BlocProvider.of<TaskCubit>(context);
        return ModalProgressHUD(
          inAsyncCall:
              state is UploadImageLoadingState || state is EditTaskLoadingState
                  ? true
                  : false,
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
                      const SizedBox(
                        height: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22),
                        child: Column(
                          children: [
                            taskCubit.image == null
                                ? AddImageButton(
                                    title: 'Edit Img',
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
                                controller: taskCubit.editTitleController,
                                label: 'Change task title',
                                hintText: 'Change title here...'),
                            const SizedBox(
                              height: 16,
                            ),
                            CustomTaskTextField(
                              autovalidateMode: taskCubit.autovalidateMode,
                              controller: taskCubit.editDescriptionController,
                              label: 'Change task Description',
                              hintText: 'Change description here...',
                              maxLines: 5,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Change Priority',
                                    style: Styles.styleRegular12(context)
                                        .copyWith(
                                            color: const Color(0xff6E6A7C))),
                                const SizedBox(height: 8),
                                const PriorityDropdown()
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Change Status',
                                    style: Styles.styleRegular12(context)
                                        .copyWith(
                                            color: const Color(0xff6E6A7C))),
                                const SizedBox(height: 8),
                                StateDropdown(
                                  id: widget.id,
                                ),
                              ],
                            ),
                            const SizedBox(height: 28.5),
                            CustomButton(
                              text: 'Edit task',
                              style: Styles.styleBold19(context),
                              hasIcon: false,
                              onPressed: () async {
                                final taskCubit =
                                    BlocProvider.of<TaskCubit>(context);
                                final isValid = taskCubit
                                    .editTaskFormKey.currentState!
                                    .validate();
                                if (!isValid) {
                                  taskCubit.updateAutovalidateMode(
                                      AutovalidateMode.always);
                                  return;
                                }
                                if (isValid &&
                                    taskCubit.image != null &&
                                    taskCubit.uploadedImage == null) {
                                  await taskCubit.uploadImage();
                                }
                                if (isValid &&
                                    taskCubit.image == null &&
                                    taskCubit.uploadedImage == null) {
                                  await taskCubit
                                      .editTask(id: widget.id, taskDetails: {
                                    "title": taskCubit.editTitleController.text,
                                    "desc": taskCubit
                                        .editDescriptionController.text,
                                    "priority": taskCubit.prioritySelected,
                                    "status": taskCubit.statusSelected,
                                  });
                                }
                                if (isValid &&
                                    taskCubit.uploadedImage != null) {
                                  await taskCubit
                                      .editTask(id: widget.id, taskDetails: {
                                    "title": taskCubit.editTitleController.text,
                                    "desc": taskCubit
                                        .editDescriptionController.text,
                                    "image": taskCubit.uploadedImage,
                                    "priority": taskCubit.prioritySelected,
                                    "status": taskCubit.statusSelected,
                                  });
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
