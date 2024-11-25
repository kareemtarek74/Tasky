import 'package:flutter/material.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/add_task_view_body.dart';

class AddTaskView extends StatelessWidget {
  const AddTaskView({super.key});
  static const String routeName = 'AddTask';
  @override
  Widget build(BuildContext context) {
    return const AddTaskViewBody();
  }
}
