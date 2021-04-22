import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:restaurantes_tipoventas_app/Modelos/clUsuarios.dart';

import 'UserSession.dart';

class AuthAPIServicio {
  final baseUrl = 'https://reqres.in';

  //Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
  Future<User> login(String email, String password) async {
    String url = "https://reqres.in/api/login";
    print("LOGIN");


    Map param = {"email": email, "password": password};

    //final response = await http.post(url, body: loginRequestModel.toJson());
    final response = await http.post(url, body: param);
    print("Estado");
    print(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 400) {
      print(response.body);
      print("bbb");

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

    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<dynamic> login2(String email, String password) async {
    try {
      var res = await http.post(
        '$baseUrl/api/login',
        body: {
          'email': email,
          'password': password,
          //'token': 'SdxIpaQp!81XS#QP5%w^cTCIV*DYr',
        },
      );

      //return res?.body;
      final Map<String, dynamic> responseData = json.decode(res.body);

      return responseData;
    } finally {
      // you can do somethig here
    }
  }
}