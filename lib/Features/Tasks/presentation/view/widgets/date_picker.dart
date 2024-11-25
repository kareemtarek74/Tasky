import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:tasky/Features/Tasks/presentation/view/view_model/Task_cubit/task_cubit.dart';
import 'package:tasky/core/text_styles.dart';

class DueDatePicker extends StatelessWidget {
  const DueDatePicker({super.key});

  Future<void> _selectDueDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );

    if (selectedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate);

      context.read<TaskCubit>().updateDueDate(formattedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        String dueDateText =
            context.read<TaskCubit>().dueDateController.text.isEmpty
                ? 'Choose due date...'
                : context.read<TaskCubit>().dueDateController.text;

        return TextField(
          controller: context.read<TaskCubit>().dueDateController,
          readOnly: true, // Makes the field non-editable
          decoration: InputDecoration(
            labelText: 'choose due date...',
            labelStyle: Styles.styleRegular14(context)
                .copyWith(color: const Color(0xff7F7F7F)),
            hintText: dueDateText,
            hintStyle: Styles.styleRegular14(context)
                .copyWith(color: const Color(0xff7F7F7F)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            suffixIcon: IconButton(
              icon: const Icon(
                FontAwesomeIcons.solidCalendarDays,
                color: Color(0xff5F33E1),
                size: 20,
              ),
              onPressed: () => _selectDueDate(context),
            ),
            border: buildBorder(),
            enabledBorder: buildBorder(),
            focusedBorder: buildBorder(),
          ),
        );
      },
    );
  }
}

OutlineInputBorder buildBorder() {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(width: 1, color: Color(0xFFBABABA)));
}
