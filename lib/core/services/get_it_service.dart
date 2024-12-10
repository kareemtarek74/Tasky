import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/Features/Auth/Data/Data_Sources/remote/profile_info_remote_data_source.dart';
import 'package:tasky/Features/Auth/Data/repos/login_repo_impl.dart';
import 'package:tasky/Features/Auth/Data/repos/logout_repo_impl.dart';
import 'package:tasky/Features/Auth/Data/repos/profile_info_repo_impl.dart';
import 'package:tasky/Features/Auth/Data/repos/refresh_token_repo_impl.dart';
import 'package:tasky/Features/Auth/Data/repos/register_repo_impl.dart';
import 'package:tasky/Features/Auth/Domain/repos/login_repo.dart';
import 'package:tasky/Features/Auth/Domain/repos/logout_repo.dart';
import 'package:tasky/Features/Auth/Domain/repos/profile_info_repo.dart';
import 'package:tasky/Features/Auth/Domain/repos/refresh_token_repo.dart';
import 'package:tasky/Features/Auth/Domain/repos/register_repo.dart';
import 'package:tasky/Features/Auth/Domain/usecases/login_usecase.dart';
import 'package:tasky/Features/Auth/Domain/usecases/logout_usecase.dart';
import 'package:tasky/Features/Auth/Domain/usecases/profile_info_usecase.dart';
import 'package:tasky/Features/Auth/Domain/usecases/refresh_token_usecase.dart';
import 'package:tasky/Features/Auth/Domain/usecases/register_usecase.dart';
import 'package:tasky/Features/Auth/presentation/view_model/auth_cubit.dart';
import 'package:tasky/Features/Tasks/Data/Data_Sources/Remote/get_task_details_remote_data_source.dart';
import 'package:tasky/Features/Tasks/Data/Data_Sources/Remote/get_tasks_list_remote_data_source.dart';
import 'package:tasky/Features/Tasks/Data/Repos/create_task_repo_impl.dart';
import 'package:tasky/Features/Tasks/Data/Repos/delete_task_repo_impl.dart';
import 'package:tasky/Features/Tasks/Data/Repos/edit_task_repo_impl.dart';
import 'package:tasky/Features/Tasks/Data/Repos/get_task_details_repo_impl.dart';
import 'package:tasky/Features/Tasks/Data/Repos/get_tasks_list_repo_impl.dart';
import 'package:tasky/Features/Tasks/Data/Repos/upload_image_repo_impl.dart';
import 'package:tasky/Features/Tasks/Domain/Repos/create_task_repo.dart';
import 'package:tasky/Features/Tasks/Domain/Repos/delete_task_repo.dart';
import 'package:tasky/Features/Tasks/Domain/Repos/edit_task_repo.dart';
import 'package:tasky/Features/Tasks/Domain/Repos/get_task_details_repo.dart';
import 'package:tasky/Features/Tasks/Domain/Repos/get_tasks_list_repo.dart';
import 'package:tasky/Features/Tasks/Domain/Repos/upload_image_repo.dart';
import 'package:tasky/Features/Tasks/Domain/usecases/create_task_usecase.dart';
import 'package:tasky/Features/Tasks/Domain/usecases/delete_task_usecase.dart';
import 'package:tasky/Features/Tasks/Domain/usecases/edit_task_usecase.dart';
import 'package:tasky/Features/Tasks/Domain/usecases/get_task_details_usecase.dart';
import 'package:tasky/Features/Tasks/Domain/usecases/get_tasks_list_usecase.dart';
import 'package:tasky/Features/Tasks/Domain/usecases/upload_image_usecase.dart';
import 'package:tasky/Features/Tasks/presentation/view/view_model/Task_cubit/task_cubit.dart';
import 'package:tasky/core/Api/api_consumer.dart';
import 'package:tasky/core/Api/api_interceptors.dart';
import 'package:tasky/core/Api/dio_consumer.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerLazySingleton(() => Dio());

  getIt.registerLazySingleton<DioConsumer>(() => DioConsumer(dio: getIt()));
  getIt.registerLazySingleton<ApiConsumer>(() => getIt<DioConsumer>());

  getIt.registerLazySingleton(() => ApiInterceptors(
        dio: getIt(),
        sharedPreferences: getIt(),
      ));

  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);

  getIt.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSourceImpl(
            apiConsumer: getIt(),
          ));

  getIt.registerLazySingleton<GetTaskDetailsRemoteDataSource>(
      () => GetTaskDetailsRemoteDataSourceImpl(
            apiConsumer: getIt(),
          ));

  getIt.registerLazySingleton<GetTasksListRemoteDataSource>(
      () => GetTasksListRemoteDataSourceImpl(
            apiConsumer: getIt(),
          ));

  getIt.registerLazySingleton<LoginRepo>(
    () => LoginRepoImpl(
      apiConsumer: getIt(),
      sharedPreferences: getIt(),
    ),
  );
  getIt.registerLazySingleton<RegisterRepo>(
    () => RegisterRepoImpl(
      apiConsumer: getIt(),
      preferences: getIt(),
    ),
  );
  getIt.registerLazySingleton<ProfileInfoRepo>(
    () => ProfileInfoRepoImpl(
      profileRemoteDataSource: getIt(),
    ),
  );
  getIt.registerLazySingleton<RefreshTokenRepo>(
    () => RefreshTokenRepoImpl(
      apiConsumer: getIt(),
      sharedPreferences: getIt(),
    ),
  );
  getIt.registerLazySingleton<LogoutRepo>(
    () => LogoutRepoImpl(
      apiConsumer: getIt(),
      sharedPreferences: getIt(),
    ),
  );

  getIt.registerLazySingleton<LoginUsecase>(
    () => LoginUsecase(
      loginRepo: getIt(),
    ),
  );
  getIt.registerLazySingleton<RegisterUsecase>(
    () => RegisterUsecase(
      registerRepo: getIt(),
    ),
  );
  getIt.registerLazySingleton<ProfileInfoUsecase>(
    () => ProfileInfoUsecase(
      profileInfoRepo: getIt(),
    ),
  );
  getIt.registerLazySingleton<RefreshTokenUsecase>(
    () => RefreshTokenUsecase(
      refreshTokenRepo: getIt(),
    ),
  );
  getIt.registerLazySingleton<UserLogoutUsecase>(
    () => UserLogoutUsecase(
      logoutRepo: getIt(),
    ),
  );

  getIt.registerFactory<AuthCubitCubit>(
    () => AuthCubitCubit(
        loginUsecase: getIt(),
        userLogoutUsecase: getIt(),
        profileInfoUsecase: getIt(),
        refreshTokenUsecase: getIt(),
        registerUsecase: getIt(),
        sharedPreferences: getIt()),
  );

  getIt.registerLazySingleton<UploadImageRepo>(() => UploadImageRepoImpl(
        apiConsumer: getIt(),
      ));

  getIt.registerLazySingleton<CreateTaskRepo>(() => CreateTaskRepoImpl(
        apiConsumer: getIt(),
      ));

  getIt.registerLazySingleton<GetTasksListRepo>(() => GetTasksListRepoImpl(
        getTasksListRemoteDataSource: getIt(),
      ));

  getIt.registerLazySingleton<GetTaskDetailsRepo>(() => GetTaskDetailsRepoImpl(
        getTaskDetailsRemoteDataSource: getIt(),
      ));

  getIt.registerLazySingleton<EditTaskRepo>(() => EditTaskRepoImpl(
        apiConsumer: getIt(),
      ));

  getIt.registerLazySingleton<DeleteTaskRepo>(() => DeleteTaskRepoImpl(
        apiConsumer: getIt(),
      ));

  getIt.registerLazySingleton<CreateTaskUseCase>(
    () => CreateTaskUseCase(
      createTaskRepo: getIt(),
    ),
  );
  getIt.registerLazySingleton<DeleteTaskUsecase>(
    () => DeleteTaskUsecase(
      deleteTaskRepo: getIt(),
    ),
  );
  getIt.registerLazySingleton<EditTaskUsecase>(
    () => EditTaskUsecase(
      editTaskRepo: getIt(),
    ),
  );
  getIt.registerLazySingleton<GetTaskDetailsUsecase>(
    () => GetTaskDetailsUsecase(
      getTaskDetailsRepo: getIt(),
    ),
  );
  getIt.registerLazySingleton<GetTasksListUsecase>(
    () => GetTasksListUsecase(
      getTasksListRepo: getIt(),
    ),
  );

  getIt.registerLazySingleton<UploadImageUsecase>(
    () => UploadImageUsecase(
      uploadImageRepo: getIt(),
    ),
  );
  getIt.registerFactory<TaskCubit>(
    () => TaskCubit(
      uploadImageUsecase: getIt(),
      createTaskUseCase: getIt(),
      getTasksListUsecase: getIt(),
      getTaskDetailsUsecase: getIt(),
      editTaskUsecase: getIt(),
      deleteTaskUsecase: getIt(),
    ),
  );
}
