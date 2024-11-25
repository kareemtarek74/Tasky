import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial());

  final Map<String, Color> flagColors = {
    "Low Priority": const Color(0xFF0087FF), // Blue
    "Medium Priority": const Color(0xFF5F33E1), // Purple
    "High Priority": const Color(0xFFFF7D53), // Orange
  };

  final Map<String, Color> fieldColors = {
    "Low Priority": const Color(0xFFEAF6FF), // Light Blue
    "Medium Priority": const Color(0xFFF4F0FF), // Light Purple
    "High Priority": const Color(0xFFFFEDE6), // Light Orange
  };

  // Method to update the priority and its associated colors
  void updatePriority(String priority) {
    emit(TaskPriorityUpdated(
      selectedPriority: priority,
      flagColor: flagColors[priority]!,
      fieldColor: fieldColors[priority]!,
    ));
  }
}
