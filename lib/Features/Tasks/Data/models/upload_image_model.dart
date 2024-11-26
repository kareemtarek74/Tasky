import 'package:tasky/Features/Tasks/Domain/Entities/upload_image_entity.dart';

class UploadImageModel extends UploadImageEntity {
  String? image;

  UploadImageModel({this.image}) : super(imagePath: image);

  factory UploadImageModel.fromJson(Map<String, dynamic> json) {
    return UploadImageModel(
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'image': image,
      };
}
