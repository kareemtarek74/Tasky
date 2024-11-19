import 'package:tasky/Features/Auth/Domain/Entites/login_entity.dart';

class LoginModel extends LoginEntity {
  String? id;
  String? accessToken;
  String? refreshToken;

  LoginModel({this.id, this.accessToken, this.refreshToken})
      : super(iD: id, accesstoken: accessToken, refreshtoken: refreshToken);

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        id: json['_id'] as String?,
        accessToken: json['access_token'] as String?,
        refreshToken: json['refresh_token'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'access_token': accessToken,
        'refresh_token': refreshToken,
      };
}
