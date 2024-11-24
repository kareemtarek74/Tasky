import 'package:flutter/material.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/my_tasks_model.dart';
import 'package:tasky/core/text_styles.dart';

class MyTasksItem extends StatelessWidget {
  const MyTasksItem({super.key, required this.isActive, required this.model});
  final bool isActive;
  final MyTasksModel model;

  @override
  Widget build(BuildContext context) {
    return isActive
        ? ActiveMyTasksItem(taskModel: model)
        : InActiveMyTasksItem(tasksModel: model);
  }
}

class ActiveMyTasksItem extends StatelessWidget {
  const ActiveMyTasksItem({super.key, required this.taskModel});
  final MyTasksModel taskModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: ShapeDecoration(
          color: const Color(0xFF5F33E1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          )),
      child: Text(
        taskModel.title,
        style: Styles.styleBold16(context).copyWith(color: Colors.white),
      ),
    );
  }
}

class InActiveMyTasksItem extends StatelessWidget {
  const InActiveMyTasksItem({super.key, required this.tasksModel});
  final MyTasksModel tasksModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: ShapeDecoration(
          color: const Color(0xFFF0ECFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          )),
      child: Text(
        tasksModel.title,
        style: Styles.styleRegular16(context)
            .copyWith(color: const Color(0xFF7C7C80)),
      ),
    );
  }
}
