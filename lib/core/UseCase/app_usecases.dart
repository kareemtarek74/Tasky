import 'package:dartz/dartz.dart';

abstract class UseCase<Type, Param> {
  Future<Either<String, Type>> call(Param param);
}

class NoParam {}

class LoginParams {
  final String phone;
  final String password;

  const LoginParams({
    required this.phone,
    required this.password,
  });
}

class RegisterParams {
  final String displayName;
  final String phone;
  final int experienceYears;
  final String password;
  final String address;
  final String level;

  const RegisterParams({
    required this.displayName,
    required this.experienceYears,
    required this.phone,
    required this.password,
    required this.address,
    required this.level,
  });
}

class CreateTaskParams {
  final String? image;
  final String? title;
  final String? desc;
  final String? priority;
  final String? dueDate;
  final String? id;
  final String? status;

  const CreateTaskParams({
    this.image,
    this.title,
    this.desc,
    this.priority,
    this.dueDate,
    this.id,
    this.status,
  });
}

class EditTaskParams {
  final String id;
  final Map<String, dynamic> data;

  const EditTaskParams({
    required this.id,
    required this.data,
  });
}
