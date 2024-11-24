import 'package:flutter/material.dart';
import 'package:tasky/Features/Tasks/presentation/view/widgets/my_tasks_list_view.dart';
import 'package:tasky/core/text_styles.dart';

class CustomHomeBody extends StatelessWidget {
  const CustomHomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 24,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Row(
            children: [
              Text(
                'My Tasks',
                style: Styles.styleBold16(context).copyWith(
                  color: const Color(0x9924252C),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const MyTasksListView()
      ],
    );
  }
}
