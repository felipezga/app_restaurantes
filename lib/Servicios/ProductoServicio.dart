import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurantes_tipoventas_app/Modelos/AgrupacionMenu.dart';
import 'package:restaurantes_tipoventas_app/Modelos/clMenu.dart';
import 'package:restaurantes_tipoventas_app/Paginas/Producto.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Configuraciones.dart';
abstract class ProductoServices{
  Future<List<clMenu>>  listarProducto( categoria );

}


class ProductoServ implements ProductoServices{
  @override
  Future<List<clMenu>>  listarProducto(categoria) async {
    List<clMenu> ProductosRestaurante = [];
    List<clMenu> Menu = [];

    try {

      //_Restaurante+"/"+_TipoVenta
      print(url_api+'/F33/55/'+categoria!);
      print("viernesss");
      final url = Uri.parse( url_api+'/F33/55/'+categoria! );
      var response = await http.get(url);

      if(response.statusCode == 200 ){
        String body = utf8.decode(response.bodyBytes);
        final jsonData = jsonDecode(body);
        print('bebe');
        //print(jsonData[0]);

        for(var item in jsonData ){
          //print(item["codigO_ALIADO"]);
          Menu.add(clMenu( item["vbR_ID"], item["bodE_NOMBRE"], item["puntO_VENTA"], item["categoria"], item["codigo"], item["codigO_ALIADO"], item["producto"], item["grupo"], item["item"], item["precio"], item["foto"]));
        }


        return Menu;

      }else{
        print(response);
        throw Exception("Fallo la conexion");
      }


    } catch (e) {

      ProductosRestaurante = [];
    }

    return ProductosRestaurante;
  }


  Future<http.Response> enviarProducto( data) async {
    print("ENVIAR POR BLOC");
    print(data);

    //print(jsonEncode(obj));
    //String url = "https://10.0.2.2:5001/api/restaurante";
    final url = Uri.parse( url_api );


    Map tempParam = {"tipoventa": 158, "restaurante": "F35"};
    var param = json.encode(tempParam);



    String da ='{"tipoventa": "158", "restaurante": "F35"}';

    Map<String, dynamic>? datos = json.decode(da);
    //Map datos = {"tipoventa": 158, "restaurante": "F35"};
    print(datos);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'cache-control': 'no-cache',
    };

    //String datos = "http://1";
    var response = await http.post(url,
        headers: headers,
        //headers: {    HttpHeaders.contentTypeHeader: 'application/json'},
        body: param );
    print(response);

    String mensaje = response.body;

    Map h = jsonDecode(mensaje);

    print(h['code']);
    print(h['mens']);
    print('Response status: ${response.statusCode}');
    print('Response body: ${mensaje}');
    print('Response body: ${response.request}');
    print('Response body: ${response.headers}');
    //Text('veve');
    return response;

  }





  List<Agrupacion> Agrupar ( List<clMenu> listaProductoCategoria){
    List<Agrupacion> _ListaProductos = [];
    List<Agrupacion> _ListaGrupos = [];
    List<Agrupacion> _ListaItems = [];

    List<String?> _ProductosTemp = [];
    List<tempProducto> ProdTemp = [];
    List<String?> _GruposTemp = [];
    List<ProductoGrupo> _ProductosGruposTemp = [];

    print('Empezo');
    print(listaProductoCategoria.length);
    for (var object in listaProductoCategoria) {
      final data = object.codigO_ALIADO!.split("-");
      final producto = data[0];
      final grupo = data[1];

      if(grupo == '0'){
        if(!_ProductosTemp.contains(producto)){
          _ProductosTemp.add(object.producto);
          ProdTemp.add(tempProducto(object.producto, object.foto));
        }
      }
    }

    print(_ListaProductos);

    //for(var producto in _ProductosTemp){
    for(var producto in ProdTemp){
      print(producto);
      for(var listaproducto in listaProductoCategoria.where((u) => u.producto == producto.descripcion ).toList() ){

        if(listaproducto.producto!.contains(producto.descripcion!)){

          final data = listaproducto.codigO_ALIADO!.split("-");
          final producto = data[0];
          final grupo = data[1];

          if(!_GruposTemp.contains(listaproducto.grupo)){
            _GruposTemp.add(listaproducto.grupo);
          }
          /*if(!_GruposTemp.contains(listaproducto.producto+listaproducto.grupo)){
            _GruposTemp.add(listaproducto.producto+listaproducto.grupo);
          }*/
        }
      }
      print(_GruposTemp);

      _ProductosGruposTemp.add(ProductoGrupo(producto.descripcion, producto.foto, _GruposTemp ));
      _GruposTemp = [];

    }

    List<clMenu> dataProducto = [];

    for(var temp_prodgrupo in _ProductosGruposTemp){
      for(var temp_grupo in temp_prodgrupo.children){
        //print('beee');
        //print(temp_grupo);
        dataProducto = listaProductoCategoria.where((u) => u.producto == temp_prodgrupo.title ).toList();
        for(var listap in dataProducto){
          if( temp_grupo == listap.grupo ){
            //_ListaItems.add(Agrupacion(listap.producto+listap.item, [] ));
            _ListaItems.add(Agrupacion(listap.item, '1', [] ));

          }
        }

        _ListaGrupos.add(Agrupacion(temp_grupo, '', _ListaItems));
        //_ListaGrupos.add(Agrupacion(temp_grupo, []));

        _ListaItems = [];

      }

      print('es hoy');
      print(_ListaGrupos);

      _ListaProductos.add(Agrupacion(temp_prodgrupo.title, temp_prodgrupo.foto, _ListaGrupos));

      _ListaGrupos = [];

    }

    print(_ProductosTemp);
    print(_GruposTemp);
    print(_ProductosGruposTemp);

    return _ListaProductos;

  }


}

class tempProducto{
  String? descripcion;
  String? foto;

  tempProducto(this.descripcion, this.foto);
}

class ProductoGrupo {
  String? title;
  String? foto;
  List children;
  ProductoGrupo(this.title, this.foto, [this.children = const []]);
}