import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/text_styles.dart';

import '../../Features/Tasks/presentation/view/view_model/Task_cubit/task_cubit.dart';

Future<void> showDeleteConfirmationDialog(
    BuildContext context, String id) async {
  final taskCubit = BlocProvider.of<TaskCubit>(context);

  return showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text(
          "Confirm Delete",
          style: Styles.styleBold24(context),
        ),
        content: Text(
          "Are you sure you want to delete this task?",
          style: Styles.styleMedium16(context).copyWith(color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: Color(0xFFFF7D53)),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              taskCubit.deleteTask(id: id);
              taskCubit.getTasksList();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF7D53),
            ),
            child: const Text(
              "Delete",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}
