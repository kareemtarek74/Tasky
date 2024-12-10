import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasky/Features/Tasks/Data/models/upload_image_model.dart';
import 'package:tasky/Features/Tasks/Domain/Entities/upload_image_entity.dart';
import 'package:tasky/Features/Tasks/Domain/Repos/upload_image_repo.dart';
import 'package:tasky/core/Api/api_consumer.dart';
import 'package:tasky/core/Api/end_points.dart';
import 'package:tasky/core/Errors/exceptions.dart';
import 'package:tasky/core/utils/file_validator.dart';
import 'package:tasky/core/utils/image_form_data_builder.dart';

class UploadImageRepoImpl extends UploadImageRepo {
  final ApiConsumer apiConsumer;

  UploadImageRepoImpl({required this.apiConsumer});

  @override
  Future<Either<String, UploadImageEntity>> uploadImage({
    required XFile image,
  }) async {
    try {
      final file = File(image.path);

      if (!FileValidator.isValidSize(file)) {
        return left(FileValidator.getSizeErrorMessage());
      }

      final formData = await ImageFormDataBuilder.build(file);

      final response =
          await apiConsumer.post(EndPoints.uploadImage, data: formData);

      return right(UploadImageModel.fromJson(response));
    } on ServerException catch (e) {
      return left(e.errorModel.message);
    }
  }
}
