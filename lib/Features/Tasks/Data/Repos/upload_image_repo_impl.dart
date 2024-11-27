import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:tasky/Features/Tasks/Data/models/upload_image_model.dart';
import 'package:tasky/Features/Tasks/Domain/Entities/upload_image_entity.dart';
import 'package:tasky/Features/Tasks/Domain/Repos/upload_image_repo.dart';
import 'package:tasky/core/Api/api_consumer.dart';
import 'package:tasky/core/Api/end_points.dart';
import 'package:tasky/core/Errors/exceptions.dart';

class UploadImageRepoImpl extends UploadImageRepo {
  final ApiConsumer apiConsumer;

  UploadImageRepoImpl({required this.apiConsumer});

  @override
  Future<Either<String, UploadImageEntity>> uploadImage(
      {required XFile image}) async {
    try {
      final file = File(image.path);
      final fileSize = await file.length();
      const maxFileSize = 5 * 1024 * 1024;
      if (fileSize > maxFileSize) {
        return left('حجم الصورة يتجاوز الحد المسموح به (5 ميجابايت).');
      }

      FormData formData = FormData.fromMap({
        ApiKeys.image: await MultipartFile.fromFile(
          image.path,
          filename: path.basename(image.path),
          contentType: MediaType(
            ApiKeys.image,
            path.extension(image.path).replaceFirst(".", ""),
          ),
        ),
      });

      final response =
          await apiConsumer.post(EndPoints.uploadImage, data: formData);

      return right(UploadImageModel.fromJson(response));
    } on ServerException catch (e) {
      return left(e.errorModel.message);
    }
  }
}
