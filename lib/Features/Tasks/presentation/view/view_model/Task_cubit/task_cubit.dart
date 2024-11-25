import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(TaskInitial()) {
    prioritySelected = "medium";
  }

  String? prioritySelected;
  String? imagePath;

  final Map<String, Color> flagColors = {
    "Low Priority": const Color(0xFF0087FF),
    "Medium Priority": const Color(0xFF5F33E1),
    "High Priority": const Color(0xFFFF7D53),
  };

  final Map<String, Color> fieldColors = {
    "Low Priority": const Color(0xFFEAF5FF),
    "Medium Priority": const Color(0xFFF4F0FF),
    "High Priority": const Color(0xFFFFEEE8),
  };

  // Mapping of display values to API values and vice versa
  final Map<String, String> displayToApi = {
    "Low Priority": "low",
    "Medium Priority": "medium",
    "High Priority": "high",
  };

  final Map<String, String> apiToDisplay = {
    "low": "Low Priority",
    "medium": "Medium Priority",
    "high": "High Priority",
  };

  // Method to update the selected priority
  void updatePriority(String displayValue) {
    prioritySelected = displayToApi[displayValue]; // Save API value
    emit(
      TaskPriorityUpdated(
        selectedPriority: displayValue,
        flagColor: flagColors[displayValue]!,
        fieldColor: fieldColors[displayValue]!,
      ),
    );
  }

  TextEditingController dueDateController = TextEditingController();

  void updateDueDate(String dueDate) {
    dueDateController.text = dueDate;
    emit(TaskDueDateUpdated(dueDate: dueDate));
  }

  void saveImagePath(String? path) {
    imagePath = path;
    emit(TaskImageUpdated(imagePath: path));
  }
}
