import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/Features/Auth/presentation/view_model/auth_cubit.dart';
import 'package:tasky/core/Api/end_points.dart';
import 'package:tasky/core/services/get_it_service.dart';

class ApiInterceptors extends Interceptor {
  final SharedPreferences sharedPreferences;
  bool isRefreshing = false;
  List<RequestOptions> requestQueue = [];
  final Dio dio;

  ApiInterceptors({
    required this.dio,
    required this.sharedPreferences,
  });

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final accessToken = sharedPreferences.getString(ApiKeys.accessToken);
    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final cubit = getIt<AuthCubitCubit>();
      await cubit.refreshToken();

      final newAccessToken = sharedPreferences.getString(ApiKeys.accessToken);
      if (newAccessToken != null && newAccessToken.isNotEmpty) {
        err.requestOptions.headers['Authorization'] = 'Bearer $newAccessToken';
        final retryResponse = await dio.request(
          err.requestOptions.path,
          options: Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
          ),
        );
        return handler.resolve(retryResponse);
      }
    }
    return super.onError(err, handler);
  }
}
