class CreateTaskEntity {
  final String? imge;
  final String? tiTle;
  final String? decription;
  final String? prior;
  final String? statue;
  final String? userId;
  final String? taskId;
  final DateTime? createAt;
  final DateTime? updateAt;
  final num? V;

  CreateTaskEntity(
      {required this.imge,
      required this.tiTle,
      required this.decription,
      required this.prior,
      required this.statue,
      required this.userId,
      required this.taskId,
      required this.createAt,
      required this.updateAt,
      required this.V});
}
