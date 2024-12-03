import 'package:flutter/material.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/edit_task_view_body.dart';

class EditTaskView extends StatelessWidget {
  const EditTaskView({super.key, required this.id});
  static const String routeName = 'editTask';
  final String id;

  @override
  Widget build(BuildContext context) {
    return EditTaskViewBody(
      id: id,
    );
  }
}
