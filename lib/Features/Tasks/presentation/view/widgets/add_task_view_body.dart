import 'package:flutter/material.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/add_image_dotted_button.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/date_picker.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/priority_selector_dropdown.dart';
import 'package:tasky/core/text_styles.dart';
import 'package:tasky/core/widgets/custom_app_bar.dart';
import 'package:tasky/core/widgets/custom_button.dart';

import 'custom_task_text_field.dart';

class AddTaskViewBody extends StatelessWidget {
  const AddTaskViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
                    const AddImageButton(),
                    const SizedBox(
                      height: 16,
                    ),
                    const CustomTaskTextField(
                        label: 'Task title', hintText: 'Enter title here...'),
                    const SizedBox(
                      height: 16,
                    ),
                    const CustomTaskTextField(
                      label: 'Task Description',
                      hintText: 'Enter description here...',
                      maxLines: 7,
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
                        onPressed: () {})
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Due date',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            // Date picker logic
            showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2100),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF5F33E1)),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Choose due date...',
                  style: TextStyle(color: Colors.grey),
                ),
                Icon(
                  Icons.calendar_today_outlined,
                  color: Color(0xFF5F33E1),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
