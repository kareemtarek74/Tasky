import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tasky/Features/Tasks/presentation/view/home_view.dart';
import 'package:tasky/Features/Tasks/presentation/view/view_model/Task_cubit/task_cubit.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/add_image_dotted_button.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/custom_task_text_field.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/date_picker.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/priority_selector_dropdown.dart';
import 'package:tasky/core/text_styles.dart';

void navigateToHome(BuildContext context) {
  Navigator.pop(context);
  Navigator.pushNamedAndRemoveUntil(
      context, HomeView.routeName, (route) => false);
}

Widget addTaskbuildImageSelector(TaskCubit taskCubit) {
  return taskCubit.image == null
      ? AddImageButton(
          title: 'Add Img',
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
        );
}

Widget buildDateSelector(BuildContext context) {
  return const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Due date',
          style: TextStyle(fontSize: 12, color: Color(0xff6E6A7C))),
      SizedBox(height: 8),
      DueDatePicker(),
    ],
  );
}

Widget buildImageSelector(TaskCubit taskCubit) {
  return taskCubit.image == null
      ? AddImageButton(
          title: 'Edit Img',
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
        );
}

Widget buildTextField({
  required TextEditingController controller,
  required String label,
  required String hintText,
  int maxLines = 1,
}) {
  return CustomTaskTextField(
    autovalidateMode: AutovalidateMode.disabled,
    controller: controller,
    label: label,
    hintText: hintText,
    maxLines: maxLines,
  );
}

Widget buildPrioritySelector(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Change Priority',
          style: Styles.styleRegular12(context)
              .copyWith(color: const Color(0xff6E6A7C))),
      const SizedBox(height: 8),
      const PriorityDropdown(),
    ],
  );
}
