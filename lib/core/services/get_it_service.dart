import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/Features/Auth/Data/repos/login_repo_impl.dart';
import 'package:tasky/Features/Auth/Data/repos/logout_repo_impl.dart';
import 'package:tasky/Features/Auth/Data/repos/refresh_token_repo_impl.dart';
import 'package:tasky/Features/Auth/Data/repos/register_repo_impl.dart';
import 'package:tasky/Features/Auth/Domain/repos/login_repo.dart';
import 'package:tasky/Features/Auth/Domain/repos/logout_repo.dart';
import 'package:tasky/Features/Auth/Domain/repos/refresh_token_repo.dart';
import 'package:tasky/Features/Auth/Domain/repos/register_repo.dart';
import 'package:tasky/core/Api/api_interceptors.dart';
import 'package:tasky/core/Api/dio_consumer.dart';
import 'package:tasky/core/Api/end_points.dart';

import '../../Features/Auth/Domain/Entites/refresh_token_entity.dart';

final getIt = GetIt.instance;

class MockRefreshTokenRepo implements RefreshTokenRepo {
  @override
  Future<Either<String, RefreshTokenEntity>> refreshToken() async {
    return left("Mock refresh token called");
  }
}

Future<void> setup() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);

  getIt.registerSingleton<DioConsumer>(
    DioConsumer(
      dio: Dio(),
      refreshTokenRepo: MockRefreshTokenRepo(),
      sharedPreferences: getIt(),
    ),
  );

  getIt.registerSingleton<RefreshTokenRepo>(
    RefreshTokenRepoImpl(
      apiConsumer: getIt<DioConsumer>(),
      sharedPreferences: getIt(),
    ),
  );

  getIt.registerSingleton<ApiInterceptors>(
    ApiInterceptors(
      refreshTokenRepo: getIt<RefreshTokenRepo>(),
      sharedPreferences: getIt(),
    ),
  );

  final dio = getIt<DioConsumer>().dio;
  dio.interceptors.add(getIt<ApiInterceptors>());

  getIt.unregister<DioConsumer>();
  getIt.registerSingleton<DioConsumer>(
    DioConsumer(
      dio: dio,
      refreshTokenRepo: getIt<RefreshTokenRepo>(),
      sharedPreferences: getIt(),
    ),
  );

  getIt.registerSingleton<LoginRepo>(
    LoginRepoImpl(
      apiConsumer: getIt<DioConsumer>(),
      sharedPreferences: getIt(),
    ),
  );

  getIt.registerSingleton<RegisterRepo>(
    RegisterRepoImpl(
      apiConsumer: getIt<DioConsumer>(),
      preferences: getIt(),
    ),
  );

  getIt.registerSingleton<LogoutRepo>(LogoutRepoImpl(
    apiConsumer: getIt<DioConsumer>(),
    sharedPreferences: getIt(),
    dioConsumer: getIt<DioConsumer>(),
  ));
  setupDioWithInterceptors();
}

void setupDioWithInterceptors() {
  final dioConsumer = getIt<DioConsumer>();
  dioConsumer.dio.interceptors.clear();
  dioConsumer.dio.interceptors.add(ApiInterceptors(
    refreshTokenRepo: getIt<RefreshTokenRepo>(),
    sharedPreferences: getIt<SharedPreferences>(),
  ));

  dioConsumer.dio.options = BaseOptions(
    baseUrl: EndPoints.baseUrl,
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 5000),
    validateStatus: (status) => status! < 500,
  );
}
