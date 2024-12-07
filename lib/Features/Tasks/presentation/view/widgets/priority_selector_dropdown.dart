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
        String selected =
            BlocProvider.of<TaskCubit>(context).detailedTask.prior.toString();
        String selectedPriority = apiToDisplay[selected].toString();
        Color flagColor = flagColors[selected] ?? const Color(0xFF5F33E1);
        Color fieldColor = fieldColors[selected] ?? const Color(0xFFF4F0FF);

        if (state is TaskPriorityUpdated) {
          selectedPriority = state.selectedPriority;
          flagColor = state.flagColor;
          fieldColor = state.fieldColor;
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 4),
          decoration: BoxDecoration(
            color: fieldColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton<String>(
            padding: EdgeInsets.zero,
            value: priorities.contains(selectedPriority)
                ? selectedPriority
                : "Medium Priority",
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

final Map<String, String> apiToDisplay = {
  "low": "Low Priority",
  "medium": "Medium Priority",
  "high": "High Priority",
};

final Map<String, Color> flagColors = {
  "low": const Color(0xFF0087FF),
  "medium": const Color(0xFF5F33E1),
  "high": const Color(0xFFFF7D53),
};

final Map<String, Color> fieldColors = {
  "low": const Color(0xFFEAF5FF),
  "medium": const Color(0xFFF4F0FF),
  "high": const Color(0xFFFFEEE8),
};
