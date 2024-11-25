import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/Features/Tasks/presentation/view/view_model/Task_cubit/task_cubit.dart';

class PriorityDropdown extends StatelessWidget {
  const PriorityDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> priorities = [
      "Low Priority",
      "Medium Priority",
      "High Priority"
    ];

    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        String selectedPriority = "Medium Priority";
        Color flagColor = const Color(0xFF5F33E1);
        Color fieldColor = const Color(0xFFF4F0FF);

        if (state is TaskPriorityUpdated) {
          selectedPriority = state.selectedPriority;
          flagColor = state.flagColor;
          fieldColor = state.fieldColor;
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: fieldColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButton<String>(
            value: selectedPriority,
            isExpanded: true,
            underline: const SizedBox(),
            icon: Icon(
              Icons.arrow_drop_down,
              color: flagColor,
            ),
            items: priorities.map((String priority) {
              return DropdownMenuItem<String>(
                value: priority,
                child: Row(
                  children: [
                    Icon(
                      Icons.flag,
                      color: context.read<TaskCubit>().flagColors[priority]!,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      priority,
                      style: TextStyle(
                        fontSize: 16,
                        color: context.read<TaskCubit>().flagColors[priority]!,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              context.read<TaskCubit>().updatePriority(newValue!);
            },
          ),
        );
      },
    );
  }
}
