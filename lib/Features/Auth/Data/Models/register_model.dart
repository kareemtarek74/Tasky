import 'package:tasky/Features/Auth/Domain/Entites/register_entity.dart';

class RegisterModel extends RegisterEntity {
  String? id;
  String? displayName;
  String? accessToken;
  String? refreshToken;

  RegisterModel({
    this.id,
    this.displayName,
    this.accessToken,
    this.refreshToken,
  }) : super(
            iD: id,
            displayname: displayName,
            accesstoken: accessToken,
            refreshtoken: refreshToken);

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        id: json['_id'] as String?,
        displayName: json['displayName'] as String?,
        accessToken: json['access_token'] as String?,
        refreshToken: json['refresh_token'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'displayName': displayName,
        'access_token': accessToken,
        'refresh_token': refreshToken,
      };
}
