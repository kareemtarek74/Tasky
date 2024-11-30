import 'package:flutter/material.dart';
import 'package:tasky/Features/Tasks/Domain/Entities/create_task_entity.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/custom_task_item.dart';

class CustomTaskListView extends StatelessWidget {
  final List<CreateTaskEntity> tasks;
  const CustomTaskListView({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            return CustomTaskItem(
              task: tasks[index],
            );
          },
        ),
      ),
    );
  }
}
