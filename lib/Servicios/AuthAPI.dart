import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:restaurantes_tipoventas_app/Modelos/clUsuarios.dart';

import '../Configuraciones.dart';
import 'UserSession.dart';

class AuthAPIServicio {

  //Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
  Future<User> login(String email, String password) async {
    String urlLogin = "https://reqres.in/api/login";
    print("LOGIN");
    final url = Uri.parse( urlLogin );


    Map param = {"email": email, "password": password};

    //final response = await http.post(url, body: loginRequestModel.toJson());
    final response = await http.post(url, body: param);
    print("Estado");
    print(response.statusCode);
    if (response.statusCode == 200 ) {
      print(response.body);

      final Map<String, dynamic> responseData = json.decode(response.body);
      //var userData = responseData['data'];
      //User authUser = User.fromJson(userData);
      User authUser = User.fromJson(responseData);
      print(authUser.name);

      UserSession().saveUser(authUser);
      return authUser;
      /*return LoginResponseModel.fromJson(
        json.decode(response.body),
      );*/

    }
    else if ( response.statusCode == 400) {
      print("bbb");

      final Map<String, dynamic> responseData = json.decode(response.body);
      User authUser = User.fromJson(responseData);
      print(authUser.name);

      UserSession().saveUser(authUser);
      return authUser;
    }

    else {
      throw Exception('Failed to load data!');
    }
  }

  Future<dynamic> login2(String email, String password) async {
    final url = Uri.parse( '$url_login/api/login' );
    try {
      var res = await http.post(
        url,
        body: {
          'email': email,
          'password': password,
          //'token': 'SdxIpaQp!81XS#QP5%w^cTCIV*DYr',
        },
      );

      //return res?.body;
      final Map<String, dynamic>? responseData = json.decode(res.body);

      return responseData;
    } finally {
      // you can do somethig here
    }
  }
}