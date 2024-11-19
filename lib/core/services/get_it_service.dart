import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/Features/Auth/Data/repos/login_repo_impl.dart';
import 'package:tasky/Features/Auth/Data/repos/register_repo_impl.dart';
import 'package:tasky/Features/Auth/Domain/repos/login_repo.dart';
import 'package:tasky/Features/Auth/Domain/repos/register_repo.dart';
import 'package:tasky/core/Api/dio_consumer.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerSingleton<DioConsumer>(DioConsumer(dio: Dio()));
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);

  getIt.registerSingleton<RegisterRepo>(RegisterRepoImpl(
      apiConsumer: getIt<DioConsumer>(), preferences: getIt()));

  getIt.registerSingleton<LoginRepo>(LoginRepoImpl(
      apiConsumer: getIt<DioConsumer>(), sharedPreferences: getIt()));
}
