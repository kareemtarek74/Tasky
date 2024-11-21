import 'package:tasky/Features/Auth/Domain/Entites/refresh_token_entity.dart';

class RefreshTokenModel extends RefreshTokenEntity {
  String? accessToken;

  RefreshTokenModel({this.accessToken}) : super(accesstoken: accessToken);

  factory RefreshTokenModel.fromJson(Map<String, dynamic> json) {
    return RefreshTokenModel(
      accessToken: json['access_token'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'access_token': accessToken,
      };
}
