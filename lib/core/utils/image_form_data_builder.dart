import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as path;
import 'package:tasky/core/Api/end_points.dart';

class ImageFormDataBuilder {
  static Future<FormData> build(File imageFile) async {
    return FormData.fromMap({
      ApiKeys.image: await MultipartFile.fromFile(
        imageFile.path,
        filename: path.basename(imageFile.path),
        contentType: MediaType(
          ApiKeys.image,
          path.extension(imageFile.path).replaceFirst(".", ""),
        ),
      ),
    });
  }
}
