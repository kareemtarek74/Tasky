import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/Features/Auth/Data/repos/login_repo_impl.dart';
import 'package:tasky/Features/Auth/Data/repos/register_repo_impl.dart';
import 'package:tasky/Features/Auth/Data/repos/refresh_token_repo_impl.dart';
import 'package:tasky/Features/Auth/Domain/repos/login_repo.dart';
import 'package:tasky/Features/Auth/Domain/repos/register_repo.dart';
import 'package:tasky/Features/Auth/Domain/repos/refresh_token_repo.dart';
import 'package:tasky/core/Api/dio_consumer.dart';
import 'package:tasky/core/Api/api_interceptors.dart';
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
      sharedPreferences: sharedPreferences,
    ),
  );

  getIt.registerSingleton<RefreshTokenRepo>(
    RefreshTokenRepoImpl(
      apiConsumer: getIt<DioConsumer>(),
      sharedPreferences: sharedPreferences,
    ),
  );

  getIt.registerSingleton<ApiInterceptors>(
    ApiInterceptors(
      refreshTokenRepo: getIt<RefreshTokenRepo>(),
      sharedPreferences: sharedPreferences,
    ),
  );

  final dio = getIt<DioConsumer>().dio;
  dio.interceptors.add(getIt<ApiInterceptors>());

  getIt.unregister<DioConsumer>();
  getIt.registerSingleton<DioConsumer>(
    DioConsumer(
      dio: dio,
      refreshTokenRepo: getIt<RefreshTokenRepo>(),
      sharedPreferences: sharedPreferences,
    ),
  );

  getIt.registerSingleton<LoginRepo>(
    LoginRepoImpl(
      apiConsumer: getIt<DioConsumer>(),
      sharedPreferences: sharedPreferences,
    ),
  );

  getIt.registerSingleton<RegisterRepo>(
    RegisterRepoImpl(
      apiConsumer: getIt<DioConsumer>(),
      preferences: sharedPreferences,
    ),
  );
}
