import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurantes_tipoventas_app/Modelos/clTipoVenta.dart';

import '../Configuraciones.dart';
abstract class TipoVentaServices{
  Future<List<clTipoVenta>>  listarTipoVenta( _myID );

}


class TipoVentaServ implements TipoVentaServices{
  @override
  Future<List<clTipoVenta>>  listarTipoVenta(_myID) async {
    List<clTipoVenta> TipoVentasRestaurante = [];
    bool isSwitched = false;

    try {

      final url = Uri.parse( url_api +'/'+_myID!);
      print(url);

      final response = await http.get(url);
      print(response.statusCode);

      if (response.statusCode == 200) {
        //print(response.body);
        String body = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(body);

        print(jsonData[0]);
        for (var item in jsonData) {
          if(item["vtV_ID"] > 14){
            isSwitched = false;
          }else{
            isSwitched = true;
          }

          TipoVentasRestaurante.add(clTipoVenta(item["vtV_ID"], 1, item["vtV_DESCRIPCION"], 'A', isSwitched));
        }

        print(TipoVentasRestaurante);



      } else {
        print(response);
        throw Exception("Fallo la conexion");
      }


    } catch (e) {

      TipoVentasRestaurante = [];
    }

    return TipoVentasRestaurante;
  }


}