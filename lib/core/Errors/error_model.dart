import 'package:tasky/core/Api/end_points.dart';

class ErrorModel {
  final String message;
  final String? error;
  final int? statusCode;

  ErrorModel(
      {required this.message, required this.error, required this.statusCode});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      message: json[ApiKeys.message],
      error: json[ApiKeys.error] ?? 'error',
      statusCode: json[ApiKeys.statusCode] ?? 50,
    );
  }
}
