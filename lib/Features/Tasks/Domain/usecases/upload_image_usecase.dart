import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/Features/Tasks/Domain/Entities/upload_image_entity.dart';
import 'package:tasky/Features/Tasks/Domain/Repos/upload_image_repo.dart';
import 'package:tasky/core/UseCase/app_usecases.dart';

class UploadImageUsecase extends UseCase<UploadImageEntity, XFile> {
  final UploadImageRepo uploadImageRepo;

  UploadImageUsecase({
    required this.uploadImageRepo,
  });
  @override
  Future<Either<String, UploadImageEntity>> call(XFile param) {
    return uploadImageRepo.uploadImage(image: param);
  }
}
