import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/Features/Tasks/Domain/Entities/create_task_entity.dart';
import 'package:tasky/Features/Tasks/Domain/Repos/create_task_repo.dart';
import 'package:tasky/Features/Tasks/Domain/Repos/delete_task_repo.dart';
import 'package:tasky/Features/Tasks/Domain/Repos/edit_task_repo.dart';
import 'package:tasky/Features/Tasks/Domain/Repos/get_task_details_repo.dart';
import 'package:tasky/Features/Tasks/Domain/Repos/get_tasks_list_repo.dart';
import 'package:tasky/Features/Tasks/Domain/Repos/upload_image_repo.dart';
import 'package:tasky/core/Api/end_points.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final UploadImageRepo uploadImageRepo;
  final CreateTaskRepo createTaskRepo;
  final GetTasksListRepo getTasksListRepo;
  final GetTaskDetailsRepo getTaskDetailsRepo;
  final EditTaskRepo editTaskRepo;
  final DeleteTaskRepo deleteTaskRepo;
  TaskCubit(
      {required this.deleteTaskRepo,
      required this.editTaskRepo,
      required this.getTaskDetailsRepo,
      required this.getTasksListRepo,
      required this.createTaskRepo,
      required this.uploadImageRepo})
      : super(TaskInitial()) {
    prioritySelected = "medium";
    statusSelected = 'waiting';
  }

  String? prioritySelected;
  String? statusSelected;
  XFile? image;
  String? uploadedImage;
  int indexNumSelected = 0;

  final createTaskFormKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  final editTaskFormKey = GlobalKey<FormState>();
  final editTitleController = TextEditingController();
  final editDescriptionController = TextEditingController();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  void updateAutovalidateMode(AutovalidateMode mode) {
    autovalidateMode = mode;
    emit(TaskAutovalidateModeUpdated(autovalidateMode));
  }

  List<CreateTaskEntity> allTasks = [];
  List<CreateTaskEntity> inPogress = [];
  List<CreateTaskEntity> waiting = [];
  List<CreateTaskEntity> finished = [];

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

  final Map<String, Color> statusColors = {
    "Finished": const Color(0xFF0087FF),
    "In Progress": const Color(0xFF5F33E1),
    "Waiting": const Color(0xFFFF7D53),
  };

  final Map<String, Color> statusFieldColors = {
    "Waiting": const Color(0xFFFFE4F2),
    "In Progress": const Color(0xFFF0ECFF),
    "Finished": const Color(0xFFE3F2FF),
  };

  final Map<String, String> statusDisplayToApi = {
    "Waiting": ApiKeys.waitingStatue,
    "In Progress": ApiKeys.progressStatue,
    "Finished": ApiKeys.finishedStatue,
  };

  void updateStatus(String displayValue) {
    statusSelected = statusDisplayToApi[displayValue];
    emit(
      TaskStatusUpdated(
        selectedStatus: displayValue,
        statusfieldColor: statusFieldColors[displayValue]!,
        statusColor: statusColors[displayValue]!,
      ),
    );
  }

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

  void updateIndexSelected(int index) {
    indexNumSelected = index;
    emit(IndexNumUpdatedSuccessState(indexnum: index));
  }

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

  void resetFields() {
    titleController.clear();
    descriptionController.clear();
    dueDateController.clear();
    image = null;
    uploadedImage = null;
    autovalidateMode = AutovalidateMode.disabled;
    emit(TaskFieldsReset());
  }

  Future<void> creatTasks() async {
    emit(CreateTaskLoadingState());
    final response = await createTaskRepo.createTask(
        image: uploadedImage,
        title: titleController.text,
        description: descriptionController.text,
        dueDate: dueDateController.text,
        priority: prioritySelected);
    response.fold((error) {
      emit(CreateTaskErrorState(errorMessage: error));
    }, (createTaskEntity) {
      resetFields();
      emit(CreateTaskSuccessState());
    });
  }

  Future<void> getTasksList() async {
    emit(GetTasksListLoadingState());
    allTasks.clear();
    inPogress.clear();
    waiting.clear();
    finished.clear();

    final response = await getTasksListRepo.getTasksList();
    response.fold((error) {
      emit(GetTasksListErrorState(errorMessage: error));
    }, (tasksListEntity) {
      for (var tasks in tasksListEntity) {
        allTasks.add(tasks);
        switch (tasks.statue) {
          case "inProgress":
            inPogress.add(tasks);
            break;
          case "waiting":
            waiting.add(tasks);
            break;
          case "finished":
            finished.add(tasks);
            break;
          default:
        }
      }
      emit(GetTasksListSuccessState());
    });
  }

  Future<void> getTaskDetails({required String iD}) async {
    emit(GetTaskDetailsLoadingState());
    final response = await getTaskDetailsRepo.getTaskDetails(id: iD);
    response.fold((error) {
      emit(GetTaskDetailsErrorState(errorMessage: error));
    }, (task) {
      editTitleController.text = task.tiTle.toString();
      editDescriptionController.text = task.decription.toString();
      emit(GetTaskDetailsSuccessState(task: task));
    });
  }

  Future<void> editTask(
      {required String id, required Map<String, dynamic> taskDetails}) async {
    emit(EditTaskLoadingState());
    allTasks.clear();
    inPogress.clear();
    waiting.clear();
    finished.clear();
    final response =
        await editTaskRepo.editTask(id: id, taskDetais: taskDetails);
    response.fold((error) {
      emit(EditTaskErrorState(errorMessage: error));
    }, (taskEdited) {
      image = null;
      uploadedImage = null;
      getTaskDetails(iD: id);
      emit(EditTaskSuccessState());
    });
  }

  Future<void> deleteTask({required String id}) async {
    emit(DeleteTaskLoadingState());
    allTasks.clear();
    inPogress.clear();
    waiting.clear();
    finished.clear();
    final response = await deleteTaskRepo.deleteTask(id: id);
    response.fold((error) {
      emit(DeleteTaskErrorState(errorMessage: error));
    }, (deleted) {
      emit(DeleteTaskSuccessState());
    });
  }
}
