import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurantes_tipoventas_app/Modelos/SalidaModel.dart';
import 'package:restaurantes_tipoventas_app/Modelos/clRestaurante.dart';
import '../Configuraciones.dart';

abstract class RestauranteServices{
  Future<Salida> listarRestaurantes( );

}


class RestauranteServ implements RestauranteServices{
  @override
  Future<Salida> listarRestaurantes() async {

    Salida salidaRest = new Salida(0, "", []);

    try {

      List<clRestaurante> Restaurantes = [];

      print("get restaurante");

      /*
      http.Response response = await http.get(
          uri,
          headers: {
            "Accept": "text/plain",
            "Content-Type": "application/json",
            'Authorization': 'Bearer $token',
          }

      );
       */
      final url = Uri.parse( url_api );
      print(url_api);
      print(url);
      var response = await http.get(url);
      print(url);

      if(response.statusCode == 200 ){
        print("pasamos");
        String body = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(body);
        print(jsonData[0]);

        for(var item in jsonData ){
          Restaurantes.add(clRestaurante( item["vbR_ID"], item["bodE_NOMBRE"], item["bodE_DESCRIPCION"]));
        }

        print(Restaurantes);
        print('primero...');

        salidaRest.code = 1;
        salidaRest.message= "OK";
        salidaRest.restaurante = Restaurantes;

      }else{
        salidaRest.code = 0;
        salidaRest.message=  "Fallo la conexion";
      }

    } catch (e) {

      salidaRest.code = 0;
      salidaRest.message=  "Problemas en la conexion con el servidor"+ e.toString();
    }

    return salidaRest;
  }


}