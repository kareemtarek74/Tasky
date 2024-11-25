import 'package:flutter/material.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/add_image_dotted_button.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/priority_selector_dropdown.dart';
import 'package:tasky/core/text_styles.dart';
import 'package:tasky/core/widgets/custom_app_bar.dart';

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
                    )
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
