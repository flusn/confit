class LoginData {
  int? userId;
  String? username;
  String? password;

  LoginData(this.userId, this.username, this.password);

  LoginData.fromJson(Map<String, dynamic> json) {
    userId = json["userId"] ?? 0;
    username = json["username"] ?? "";
    password = json["password"] ?? "";
  }
}
