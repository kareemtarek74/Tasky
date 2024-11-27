import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/Features/Tasks/Domain/Repos/upload_image_repo.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final UploadImageRepo uploadImageRepo;
  TaskCubit({required this.uploadImageRepo}) : super(TaskInitial()) {
    prioritySelected = "medium";
  }
  static TaskCubit get(context) => BlocProvider.of(context);

  String? prioritySelected;
  XFile? image;
  String? uploadedImage;

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

  void updatePriority(String displayValue) {
    prioritySelected = displayToApi[displayValue];
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

  void saveImagePath(XFile? path) {
    image = path;
    emit(TaskImageUpdated(imagePath: path));
  }

  Future<void> uploadImage() async {
    emit(UploadImageLoadingState());
    if (image != null) {
      final response = await uploadImageRepo.uploadImage(image: image!);

      response.fold(
        (error) {
          debugPrint('خطأ أثناء رفع الصورة: $error');
          emit(UploadImageErrorState(errorMessage: error));
        },
        (imageEntity) {
          uploadedImage = imageEntity.imagePath;
          debugPrint('تم رفع الصورة بنجاح: $uploadedImage');
          emit(UploadImageSuccessState());
        },
      );
    } else {
      emit(const UploadImageErrorState(
          errorMessage: 'يرجى اختيار صورة قبل رفعها.'));
    }
  }
}
