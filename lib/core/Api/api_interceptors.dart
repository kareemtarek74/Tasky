import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/Features/Auth/Domain/repos/refresh_token_repo.dart';
import 'package:tasky/core/Api/end_points.dart';

class ApiInterceptors extends Interceptor {
  final RefreshTokenRepo refreshTokenRepo;
  final SharedPreferences sharedPreferences;

  ApiInterceptors({
    required this.refreshTokenRepo,
    required this.sharedPreferences,
  });

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = sharedPreferences.getString(ApiKeys.accessToken);
    if (accessToken != null) {
      options.headers['Authorization'] = 'bearer $accessToken';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final refreshResult = await refreshTokenRepo.refreshToken();

      refreshResult.fold(
        (error) {
          handler.reject(err);
        },
        (refreshTokenEntity) async {
          final newAccessToken = refreshTokenEntity.accesstoken;
          if (newAccessToken != null) {
            await sharedPreferences.setString(
                ApiKeys.accessToken, newAccessToken);

            final originalRequest = err.requestOptions;
            originalRequest.headers['Authorization'] = 'bearer $newAccessToken';
            final response = await Dio().fetch(originalRequest);
            handler.resolve(response);
          } else {
            handler.reject(err);
          }
        },
      );
    } else {
      super.onError(err, handler);
    }
  }
}
