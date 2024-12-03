import 'package:dartz/dartz.dart';

abstract class EditTaskRepo {
  Future<Either<String, String>> editTask(
      {required String id, required Map<String, dynamic> taskDetais});
}
