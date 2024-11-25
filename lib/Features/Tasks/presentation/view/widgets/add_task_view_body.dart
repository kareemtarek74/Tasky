import 'package:flutter/material.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/add_image_dotted_button.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/priority_selector_dropdown.dart';
import 'package:tasky/core/widgets/custom_app_bar.dart';

import 'custom_task_text_field.dart';

class AddTaskViewBody extends StatelessWidget {
  const AddTaskViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppBar(title: 'Add new task'),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22),
                child: Column(
                  children: [
                    AddImageButton(),
                    SizedBox(
                      height: 16,
                    ),
                    CustomTaskTextField(
                        label: 'Task title', hintText: 'Enter title here...'),
                    SizedBox(
                      height: 16,
                    ),
                    CustomTaskTextField(
                      label: 'Task Description',
                      hintText: 'Enter description here...',
                      maxLines: 7,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    PriorityDropdown()
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
