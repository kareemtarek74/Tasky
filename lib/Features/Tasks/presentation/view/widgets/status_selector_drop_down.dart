import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tasky/Features/Tasks/presentation/view/view_model/Task_cubit/task_cubit.dart';

import '../../../../../core/Api/end_points.dart';

class StateDropdown extends StatelessWidget {
  const StateDropdown({super.key, required this.id});
  final String id;

  @override
  Widget build(BuildContext context) {
    final List<String> status = [
      "Waiting",
      "In Progress",
      "Finished",
    ];

    return BlocBuilder<TaskCubit, TaskState>(
      builder: (context, state) {
        String selected =
            BlocProvider.of<TaskCubit>(context).detailedTask.statue.toString();
        String selectedState = statusApiToDisplay[selected].toString();
        Color fieldColor =
            statusFieldColors[selected] ?? const Color(0xFFFFE4F2);
        Color statusColor = statusColors[selected] ?? const Color(0xFFFF7D53);

        if (state is TaskStatusUpdated) {
          selectedState = state.selectedStatus;
          fieldColor = state.statusfieldColor;
          statusColor = state.statusColor;
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 4),
          decoration: BoxDecoration(
            color: fieldColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButton<String>(
            padding: EdgeInsets.zero,
            value: status.contains(selectedState) ? selectedState : "Waiting",
            isExpanded: true,
            underline: const SizedBox(),
            icon: Icon(
              FontAwesomeIcons.caretDown,
              color: statusColor,
              size: 24,
            ),
            items: status.map((String statue) {
              return DropdownMenuItem<String>(
                value: statue,
                child: Row(
                  children: [
                    const SizedBox(width: 16),
                    Text(
                      statue,
                      style: TextStyle(
                        fontSize: 16,
                        color: context.read<TaskCubit>().statusColors[statue]!,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: (String? newValue) async {
              if (newValue != null) {
                context.read<TaskCubit>().updateStatus(newValue);
              }
            },
          ),
        );
      },
    );
  }
}

final Map<String, String> statusApiToDisplay = {
  ApiKeys.waitingStatue: "Waiting",
  ApiKeys.progressStatue: "In Progress",
  ApiKeys.finishedStatue: "Finished",
};

final Map<String, Color> statusColors = {
  ApiKeys.finishedStatue: const Color(0xFF0087FF),
  ApiKeys.progressStatue: const Color(0xFF5F33E1),
  ApiKeys.waitingStatue: const Color(0xFFFF7D53),
};

final Map<String, Color> statusFieldColors = {
  ApiKeys.waitingStatue: const Color(0xFFFFE4F2),
  ApiKeys.progressStatue: const Color(0xFFF0ECFF),
  ApiKeys.finishedStatue: const Color(0xFFE3F2FF),
};
