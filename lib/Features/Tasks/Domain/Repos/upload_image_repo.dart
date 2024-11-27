import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/Features/Tasks/Domain/Entities/upload_image_entity.dart';

abstract class UploadImageRepo {
  Future<Either<String, UploadImageEntity>> uploadImage({required XFile image});
}
