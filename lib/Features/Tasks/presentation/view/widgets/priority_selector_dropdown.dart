import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasky/Features/Tasks/presentation/view/view_model/Task_cubit/task_cubit.dart';

class PriorityDropdown extends StatelessWidget {
  const PriorityDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> priorities = [
      "Low Priority",
      "Medium Priority",
      "High Priority",
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
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 6),
          decoration: BoxDecoration(
            color: fieldColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton<String>(
            padding: EdgeInsets.zero,
            value: selectedPriority,
            isExpanded: true,
            underline: const SizedBox(),
            icon: Icon(
              FontAwesomeIcons.caretDown,
              color: flagColor,
              size: 24,
            ),
            items: priorities.map((String priority) {
              return DropdownMenuItem<String>(
                value: priority,
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    Icon(
                      FontAwesomeIcons.flag,
                      color: context.read<TaskCubit>().flagColors[priority]!,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      priority,
                      style: TextStyle(
                        fontSize: 16,
                        color: context.read<TaskCubit>().flagColors[priority]!,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                context.read<TaskCubit>().updatePriority(newValue);
              }
            },
          ),
        );
      },
    );
  }
}
