class LoginEntity {
  final String? iD;
  final String? accesstoken;
  final String? refreshtoken;

  LoginEntity(
      {required this.iD,
      required this.accesstoken,
      required this.refreshtoken});
}
