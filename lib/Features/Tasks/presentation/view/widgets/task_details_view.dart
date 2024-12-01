import 'package:flutter/material.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/task_details_view_body.dart';

class TaskDetailsView extends StatelessWidget {
  const TaskDetailsView({super.key, required this.id});
  final String id;
  static const String routeName = 'taskDetails';
  @override
  Widget build(BuildContext context) {
    return TaskDetailsViewBody(
      iD: id,
    );
  }
}
