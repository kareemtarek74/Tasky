import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
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
      {required File image}) async {
    try {
      FormData formData = FormData.fromMap({
        ApiKeys.image: await MultipartFile.fromFile(
          image.path,
          filename: image.path.split('/').last,
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
