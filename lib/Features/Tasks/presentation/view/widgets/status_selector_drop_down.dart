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
        String selectedState = "Waiting";
        Color fieldColor = const Color(0xFFFFE4F2);
        Color statusColor = const Color(0xFFFF7D53);

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
            value: selectedState,
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

final Map<String, String> statusDisplayToApi = {
  "Waiting": ApiKeys.waitingStatue,
  "In Progress": ApiKeys.progressStatue,
  "Finished": ApiKeys.finishedStatue,
};
