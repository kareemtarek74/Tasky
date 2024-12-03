import 'package:dartz/dartz.dart';

abstract class DeleteTaskRepo {
  Future<Either<String, String>> deleteTask({required String id});
}
