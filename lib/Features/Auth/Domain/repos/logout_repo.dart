import 'package:dartz/dartz.dart';

abstract class LogoutRepo {
  Future<Either<String, String>> logoutUser();
}
