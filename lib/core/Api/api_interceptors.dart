import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/Features/Auth/Domain/repos/refresh_token_repo.dart';
import 'package:tasky/core/Api/end_points.dart';

class ApiInterceptors extends Interceptor {
  final RefreshTokenRepo refreshTokenRepo;
  final SharedPreferences sharedPreferences;
  bool isRefreshing = false;
  List<RequestOptions> requestQueue = [];

  ApiInterceptors({
    required this.refreshTokenRepo,
    required this.sharedPreferences,
  });

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final noAuthRequiredPaths = [
      EndPoints.login,
      EndPoints.register,
    ];

    if (noAuthRequiredPaths.contains(options.path)) {
      super.onRequest(options, handler);
      return;
    }

    final accessToken = sharedPreferences.getString(ApiKeys.accessToken);
    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final isLoggedOut =
          sharedPreferences.getString(ApiKeys.accessToken) == null;

      if (isLoggedOut) {
        handler.next(err);
        return;
      }

      final refreshResult = await refreshTokenRepo.refreshToken();

      refreshResult.fold(
        (error) {
          handler.reject(err);
        },
        (refreshTokenEntity) async {
          final newAccessToken = refreshTokenEntity.accesstoken;
          if (newAccessToken != null && newAccessToken.isNotEmpty) {
            await sharedPreferences.setString(
                ApiKeys.accessToken, newAccessToken);

            final originalRequest = err.requestOptions;
            originalRequest.headers['Authorization'] = 'Bearer $newAccessToken';

            try {
              final response = await Dio().fetch(originalRequest);
              handler.resolve(response);
            } on DioException catch (fetchError) {
              handler.reject(fetchError);
            }
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
