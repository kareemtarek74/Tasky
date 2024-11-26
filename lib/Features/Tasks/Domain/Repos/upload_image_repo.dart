import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:tasky/Features/Tasks/Domain/Entities/upload_image_entity.dart';

abstract class UploadImageRepo {
  Future<Either<String, UploadImageEntity>> uploadImage({required File image});
}
