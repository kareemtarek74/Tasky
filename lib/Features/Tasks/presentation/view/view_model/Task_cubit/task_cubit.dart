import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/Features/Tasks/Domain/Entities/create_task_entity.dart';
import 'package:tasky/Features/Tasks/Domain/usecases/create_task_usecase.dart';
import 'package:tasky/Features/Tasks/Domain/usecases/delete_task_usecase.dart';
import 'package:tasky/Features/Tasks/Domain/usecases/edit_task_usecase.dart';
import 'package:tasky/Features/Tasks/Domain/usecases/get_task_details_usecase.dart';
import 'package:tasky/Features/Tasks/Domain/usecases/get_tasks_list_usecase.dart';
import 'package:tasky/Features/Tasks/Domain/usecases/upload_image_usecase.dart';
import 'package:tasky/core/Api/end_points.dart';
import 'package:tasky/core/UseCase/app_usecases.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final GetTasksListUsecase getTasksListUsecase;
  final GetTaskDetailsUsecase getTaskDetailsUsecase;
  final UploadImageUsecase uploadImageUsecase;
  final CreateTaskUseCase createTaskUseCase;
  final DeleteTaskUsecase deleteTaskUsecase;
  final EditTaskUsecase editTaskUsecase;
  TaskCubit(
      {required this.deleteTaskUsecase,
      required this.editTaskUsecase,
      required this.getTaskDetailsUsecase,
      required this.getTasksListUsecase,
      required this.createTaskUseCase,
      required this.uploadImageUsecase})
      : super(TaskInitial()) {
    prioritySelected = "medium";
    statusSelected = 'waiting';
  }

  CreateTaskEntity detailedTask = CreateTaskEntity(
      tiTle: '',
      decription: '',
      imge: '',
      statue: '',
      prior: '',
      taskId: '',
      userId: '',
      V: 0,
      createAt: DateTime.now(),
      updateAt: DateTime.now());

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

  int currentPage = 1;
  bool isLoadingMore = false;
  bool hasMoreData = true;

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
      final response = await uploadImageUsecase.call(image!);

      response.fold(
        (error) {
          emit(UploadImageErrorState(errorMessage: error));
        },
        (imageEntity) {
          uploadedImage = imageEntity.imagePath;
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
    final params = CreateTaskParams(
        image: uploadedImage,
        title: titleController.text,
        desc: descriptionController.text,
        dueDate: dueDateController.text,
        priority: prioritySelected);
    final response = await createTaskUseCase.call(params);
    response.fold((error) {
      emit(CreateTaskErrorState(errorMessage: error));
    }, (createTaskEntity) {
      resetFields();
      emit(CreateTaskSuccessState());
    });
  }

  Future<void> getTasksList({bool loadMore = false}) async {
    if (loadMore) {
      if (!hasMoreData || isLoadingMore) return;
      isLoadingMore = true;
      emit(GetTasksListLoadingMoreState());
    } else {
      emit(GetTasksListLoadingState());
      allTasks.clear();
      inPogress.clear();
      waiting.clear();
      finished.clear();
      currentPage = 1;
      hasMoreData = true;
    }

    final response = await getTasksListUsecase.call(currentPage);
    response.fold((error) {
      if (loadMore) {
        isLoadingMore = false;
      }
      emit(GetTasksListErrorState(errorMessage: error));
    }, (tasksListEntity) {
      if (loadMore) {
        isLoadingMore = false;
        if (tasksListEntity.isEmpty || tasksListEntity.length < 20) {
          hasMoreData = false;
        }
        allTasks.addAll(tasksListEntity);
        for (var task in tasksListEntity) {
          _addToSpecificList(task);
        }
      } else {
        allTasks = tasksListEntity;
        hasMoreData = tasksListEntity.length == 20;
        for (var task in tasksListEntity) {
          _addToSpecificList(task);
        }
      }

      currentPage++;
      emit(GetTasksListSuccessState());
    });
  }

  void _addToSpecificList(CreateTaskEntity task) {
    switch (task.statue) {
      case "inProgress":
        inPogress.add(task);
        break;
      case "waiting":
        waiting.add(task);
        break;
      case "finished":
        finished.add(task);
        break;
      default:
        break;
    }
  }

  Future<void> getTaskDetails({required String iD}) async {
    emit(GetTaskDetailsLoadingState());
    final response = await getTaskDetailsUsecase.call(iD);
    response.fold((error) {
      emit(GetTaskDetailsErrorState(errorMessage: error));
    }, (task) {
      detailedTask = task;
      statusSelected = task.statue;
      prioritySelected = task.prior;
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
    final params = EditTaskParams(id: id, data: taskDetails);
    final response = await editTaskUsecase.call(params);
    response.fold((error) {
      emit(EditTaskErrorState(errorMessage: error));
    }, (taskEdited) {
      image = null;
      uploadedImage = null;

      emit(EditTaskSuccessState());
    });
  }

  Future<void> deleteTask({required String id}) async {
    emit(DeleteTaskLoadingState());
    allTasks.clear();
    inPogress.clear();
    waiting.clear();
    finished.clear();
    final response = await deleteTaskUsecase.call(id);
    response.fold((error) {
      emit(DeleteTaskErrorState(errorMessage: error));
    }, (deleted) {
      emit(DeleteTaskSuccessState());
    });
  }
}
