import 'package:tasky/Features/Auth/Domain/Entites/profile_info_entity.dart';

class ProfileInfoModel extends ProfileInfoEntity {
  String? id;
  String? displayName;
  String? username;
  List<dynamic>? roles;
  bool? active;
  num? experienceYears;
  String? address;
  String? level;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  ProfileInfoModel({
    this.id,
    this.displayName,
    this.username,
    this.roles,
    this.active,
    this.experienceYears,
    this.address,
    this.level,
    this.createdAt,
    this.updatedAt,
    this.v,
  }) : super(
            name: displayName,
            phone: username,
            leveL: level,
            experience: experienceYears,
            location: address);

  factory ProfileInfoModel.fromJson(Map<String, dynamic> json) {
    return ProfileInfoModel(
      id: json['_id'] as String?,
      displayName: json['displayName'] as String?,
      username: json['username'] as String?,
      roles: json['roles'] as List<dynamic>?,
      active: json['active'] as bool?,
      experienceYears: json['experienceYears'] as num?,
      address: json['address'] as String?,
      level: json['level'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      v: json['__v'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'displayName': displayName,
        'username': username,
        'roles': roles,
        'active': active,
        'experienceYears': experienceYears,
        'address': address,
        'level': level,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
      };
}
