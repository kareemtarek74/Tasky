import 'package:tasky/Features/Tasks/Domain/Entities/create_task_entity.dart';

class CreateTaskModel extends CreateTaskEntity {
  String? image;
  String? title;
  String? desc;
  String? priority;
  String? status;
  String? user;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  num? v;

  CreateTaskModel({
    this.image,
    this.title,
    this.desc,
    this.priority,
    this.status,
    this.user,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  }) : super(
            imge: image,
            tiTle: title,
            decription: desc,
            prior: priority,
            statue: status,
            userId: user,
            taskId: id,
            createAt: createdAt,
            updateAt: updatedAt,
            V: v);

  factory CreateTaskModel.fromJson(Map<String, dynamic> json) {
    return CreateTaskModel(
      image: json['image'] as String?,
      title: json['title'] as String?,
      desc: json['desc'] as String?,
      priority: json['priority'] as String?,
      status: json['status'] as String?,
      user: json['user'] as String?,
      id: json['_id'] as String?,
      createdAt:
          json['createdAt'] == null ? null : DateTime.parse(json['createdAt']),
      updatedAt:
          json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt']),
      v: json['__v'] as num?,
    );
  }

  Map<String, dynamic> toJson() => {
        'image': image,
        'title': title,
        'desc': desc,
        'priority': priority,
        'status': status,
        'user': user,
        '_id': id,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
      };
}
