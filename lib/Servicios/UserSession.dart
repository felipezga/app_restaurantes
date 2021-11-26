import 'package:restaurantes_tipoventas_app/Modelos/clUsuarios.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserSession {
  Future<bool> saveUser(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Estamos guardando");

    print(user.token);
    prefs.setInt("userId", user.userId != null ? user.userId! : 123 );
    prefs.setString("name", user.name!);
    prefs.setString("email", user.email != null ? user.userId as String : "felipe.rios@frisby.co" );
    prefs.setString("token", user.token!);
    prefs.setString("error", user.error!);

    print("object prefere");

    Future<bool> commit() async => true;
    return commit();
  }

  Future<User> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    int? userId = prefs.getInt("userId");
    String? name = prefs.getString("name");
    String? email = prefs.getString("email");
    String? token = prefs.getString("token");
    String? error = prefs.getString("error");

    return User(
        userId: userId, name: name, email: email, token: token, error: error);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("name");
    prefs.remove("email");
    prefs.remove("token");
    prefs.remove("error");
  }

  Future<String?> getToken(args) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");
    return token;
  }
}
