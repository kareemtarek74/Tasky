import 'package:dio/dio.dart';
import 'package:tasky/core/Errors/error_model.dart';

class ServerException implements Exception {
  final ErrorModel errorModel;

  ServerException({required this.errorModel});
}

void handleDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(
          errorModel: ErrorModel.fromJson(
              {"message": "There is a network connection problem"}));
    case DioExceptionType.sendTimeout:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.receiveTimeout:
      throw ServerException(
          errorModel: ErrorModel.fromJson({
        "message":
            "انتهت مهلة الاستجابة. يرجى المحاولة لاحقًا أو التحقق من اتصالك بالإنترنت."
      }));
    case DioExceptionType.badCertificate:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.cancel:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response!.data));
    case DioExceptionType.connectionError:
      throw ServerException(
          errorModel: ErrorModel.fromJson(
              {"message": "There is a network connection problem"}));
    case DioExceptionType.unknown:
      throw ServerException(
          errorModel: ErrorModel.fromJson(
              {"message": "There is a problem please try again"}));
    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400:
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));
        case 401:
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));
        case 403:
          throw ServerException(
              errorModel: ErrorModel.fromJson({"message": "Refresh Faild"}));
        case 422:
          throw ServerException(
              errorModel: ErrorModel.fromJson(e.response!.data));
      }
  }
}
