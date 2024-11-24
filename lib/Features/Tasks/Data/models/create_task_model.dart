class CreateTaskModel {
  String? image;
  String? title;
  String? desc;
  String? priority;
  String? status;
  String? user;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

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
  });

  factory CreateTaskModel.fromJson(Map<String, dynamic> json) {
    return CreateTaskModel(
      image: json['image'] as String?,
      title: json['title'] as String?,
      desc: json['desc'] as String?,
      priority: json['priority'] as String?,
      status: json['status'] as String?,
      user: json['user'] as String?,
      id: json['_id'] as String?,
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
