class User {
  int userId;
  String name;
  String email;
  String token;
  final String error;

  User({
    this.userId,
    this.name,
    this.email,
    this.token,
    this.error,
  });

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
        //userId: responseData["userId"] != null ? responseData["userId"] : "",
        name: responseData["token"] != null ? "Felipe" : "",
        //email: responseData["email"] != null ? responseData["email"] : "",
        token: responseData["token"] != null ? responseData["token"] : "",
        error: responseData["error"] != null ? responseData["error"] : "");
  }
}
