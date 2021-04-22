import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:restaurantes_tipoventas_app/Modelos/AgrupacionMenu.dart';
import 'package:restaurantes_tipoventas_app/Modelos/clMenu.dart';
import 'package:http/http.dart' as http;
import 'package:restaurantes_tipoventas_app/Modelos/clRestaurante.dart';

class Productos extends StatefulWidget{

  //List<clMenu> productos = [];
  String categoria;
  Productos({ this.categoria});
  //Productos({ this.productos, this.categoria});


  _ProductosState createState() => _ProductosState();
}
class _ProductosState extends State<Productos>{

  //String url = "http://10.0.2.2:5000/api/restaurante/F35/55/";
  String url = "https://10.0.2.2:5001/api/restaurante/F33/55/";
  List<clMenu> Menu = [];
  List<clMenu> _productosCategoria = [];

  List<Agrupacion> _menuAgrupado = [];
  String categoria;

  List<Agrupacion> _ListaProductos = [];
  List<Agrupacion> _ListaGrupos = [];
  List<Agrupacion> _ListaItems = [];

  List<String> _ProductosTemp = [];
  List<tempProducto> ProdTemp = [];
  List<String> _GruposTemp = [];
  List<ProductoGrupo> _ProductosGruposTemp = [];
  _getMenu() async {
    //_Restaurante+"/"+_TipoVenta
    print(url+categoria);
    print("viernesss");
    var response = await http.get(url+categoria);

    if(response.statusCode == 200 ){
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      print('bebe');
      //print(jsonData[0]);

      for(var item in jsonData ){
        //print(item["codigO_ALIADO"]);
        Menu.add(clMenu( item["vbR_ID"], item["bodE_NOMBRE"], item["puntO_VENTA"], item["categoria"], item["codigo"], item["codigO_ALIADO"], item["producto"], item["grupo"], item["item"], item["precio"], item["foto"]));
      }

      /*print(Menu);
      print('primero...');

      print('tamaño 2');
      print(Menu.length);*/

      return Menu;

    }else{
      print(response);
      throw Exception("Fallo la conexion");
    }
  }





  @override
  void initState(){
    super.initState();

    categoria =widget.categoria;

    _getMenu().then((value) {
      setState(() {
        _productosCategoria = value;
        print('dale');

        Agrupar(_productosCategoria);

      });
    });


    //_productosCategoria = _productos.toList();
    //_productosCategoria = _productos.where((p) => p.categoria == 'Promociones').toList();

    print("promociones:");
    print(_productosCategoria.length);
    print(_productosCategoria);

    print('_______ _ _ _ ______');


  }

  List<Agrupacion> Agrupar ( List<clMenu> listaProductoCategoria){

    print('Empezo');
    print(listaProductoCategoria.length);
    for (var object in listaProductoCategoria) {
      final data = object.codigO_ALIADO.split("-");
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

        if(listaproducto.producto.contains(producto.descripcion)){

          final data = listaproducto.codigO_ALIADO.split("-");
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

  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoria),
      ),
      /*body: ListView.builder(
        itemCount: _ListaProductos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${_ListaProductos[index].title}'),
            subtitle: Text(_ListaProductos[index].title),
            //title: Text('${_productosCategoria[index].codigO_ALIADO}'),
            //subtitle: Text(_productosCategoria[index].item),
          );
        },
      ),*/

      body: new ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return new StuffInTiles(_ListaProductos[index]);
          //return new StuffInTiles(listOfTiles[index]);

        },
        itemCount: _ListaProductos.length,
        //itemCount: listOfTiles.length,
      ),
      //backgroundColor: Colors.white,

    );
  }
}


class StuffInTiles extends StatelessWidget {
  //final MyTile myTile;
  final Agrupacion myTile;
  StuffInTiles(this.myTile);



  @override
  Widget build(BuildContext context) {
    return _buildTiles(myTile);
  }
  Widget _buildTiles(Agrupacion t) {

  //Widget _buildTiles(MyTile t) {
    if (t.children.isEmpty)
      return new ListTile(
          dense: true,
          enabled: true,
          isThreeLine: false,
          onLongPress: () => print("long press"),
          onTap: () => print("tap"),
          //subtitle: new Text("Subtitle"),
          //leading: new Text("Leading"),
          //https://cdn.passporthealthglobal.com/wp-content/uploads/2018/08/vacunas-consejos-peru.jpg
          //leading: new Image.asset('images/'+t.image+'.png', width: 90, height: 90),
          selected: true,
          //trailing: Icon(Icons.replay_circle_filled ),
          title: new Text(t.title));

    return
     (t.image == '') ?  new ExpansionTile(
       //key: new PageStorageKey<int>(3),
       backgroundColor: Colors.black12,
       title: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Expanded(
             child: new Text(t.title),
          ),
        ],
      ),
      children: t.children.map(_buildTiles).toList(),
     ) :
       new ExpansionTile(
        //key: new PageStorageKey<int>(3),
        backgroundColor: Colors.black12,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Expanded(
                child:
                    Row(
            children: [
              IconButton(
                icon: new Icon(Icons.replay_circle_filled, color: Colors.red,),
                highlightColor: Colors.pink,
                onPressed: (){  _enviarProducto().then((value) {
                                String mensaje = value.body;

                                Map h = jsonDecode(mensaje);
                                  setState(() {
                                    //filteredRestaurantes = value;
                                    //Text(value);
                                  });
                                });
                },
              ),
              //Image.asset('images/'+t.image+'.png', width: 90, height: 90),
              Image.network("https://wsres.vensis.com.co/wsapp/product/"+t.image, width: 90, height: 90),

            ],
        )

              //
              //Image.network('https://cdn.passporthealthglobal.com/wp-content/uploads/2018/08/vacunas-consejos-peru.jpg'),
            ),

            Expanded(
              child: new Text(t.title),
            ),
       ],

        ),
        children: t.children.map(_buildTiles).toList(),
      );

  }

  void setState(Null Function() param0) {}

  bool isSwitched = false;
  bool buscador = false;
  List<clRestaurante> Restaurantes = [];
  List<clRestaurante>  filteredRestaurantes = [];


  /*
  _enviarProducto() async {

    String url = "http://10.0.2.2:5000/api/restaurante";
    var response = await http.get(url);
    //return response;

    if(response.statusCode == 200 ){
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      print(jsonData[0]);

      for(var item in jsonData ){
        Restaurantes.add(clRestaurante( item["vbR_ID"], item["bodE_NOMBRE"], item["bodE_DESCRIPCION"]));
      }

      print(Restaurantes);
      print('primero...');

      return Restaurantes;

    }else{
      print(response);
      throw Exception("Fallo la conexion");
    }
  }
*/

  Future<http.Response> _enviarProducto() async {

      final jsonString = '{"tipoventa": 1,"restaurante": "john@example.com"}';
      Map userMap = jsonDecode(jsonString);
      var user = Student.fromJson(userMap);

      print('Howdy, ${user.tipoventa}!');
      print('We sent the verification link to ${user.restaurante}.');
      print(user);

      /*
      print("hola");
      final obj =  Student();
      //print(obj.toJson());
      */

      //print(jsonEncode(obj));
      String url = "https://10.0.2.2:5001/api/restaurante";



      /*
      Map data = {"tipoventa": 158, "restaurante": "F35"};

      //encode Map to JSON
      var body = json.encode(data);

      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(json.encode(data)));
      HttpClientResponse response = await request.close();
      // todo - you should check the response.statusCode
      String reply = await response.transform(utf8.decoder).join();

      print(response.statusCode);
      print(response.isRedirect);
      print(response.headers);
      httpClient.close();*/


      Map tempParam = {"tipoventa": 158, "restaurante": "F35"};
      var param = json.encode(tempParam);


      var f = '{"tipoventa": 123,"restaurante": "F35"}';

      String da ='{"tipoventa": "158", "restaurante": "F35"}';

      Map<String, dynamic> datos = json.decode(da);
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

      //print(await http.read('https://example.com/foobar.txt'));
      //return "feliperr";

    /*
    * Map data = {
      'tipoventa': 1,
      'restaurante': "some text"
    };

    String body = json.encode(data);

    http.Response response = await http.post(url, headers: {"Content-Type": "application/json"}, body: body,);
    print(response.statusCode);
    print(response.isRedirect);
    print(response.headers);
    * */

/*
      Map data = {"tipoventa": 158, "restaurante": "F35"};

      //encode Map to JSON
      var body = json.encode(data);

      var response = await http.post(url,
          headers: {"Content-Type": "application/json"},
          body: body
      );
      print("${response.statusCode}");
      print("${response.body}");
      return response;*/
    }
}

class MyTile {
  String title;
  List<MyTile> children;
  MyTile(this.title, [this.children = const <MyTile>[]]);
}

class tempProducto{
  String descripcion;
  String foto;

  tempProducto(this.descripcion, this.foto);
}

class ProductoGrupo {
  String title;
  String foto;
  List children;
  ProductoGrupo(this.title, this.foto, [this.children = const []]);
}

List<MyTile> listOfTiles = <MyTile>[
  new MyTile(
    'Animals',
    <MyTile>[
      new MyTile(
        'Dogs',
        <MyTile>[
          new MyTile('Coton de Tulear'),
          new MyTile('German Shepherd'),
          new MyTile('Poodle'),
        ],
      ),
      new MyTile('Cats'),
      new MyTile('Birds'),
    ],
  ),
  new MyTile(
    'Cars',
    <MyTile>[
      new MyTile('Tesla'),
      new MyTile('Toyota'),
    ],
  ),
  new MyTile(
    'Phones',
    <MyTile>[
      new MyTile('Google'),
      new MyTile('Samsung'),
      new MyTile(
        'OnePlus',
        <MyTile>[
          new MyTile('1'),
          new MyTile('2'),
          new MyTile('3'),
          new MyTile('4'),
          new MyTile('5'),
          new MyTile('6'),
          new MyTile('7'),
          new MyTile('8'),
          new MyTile('9'),
          new MyTile('10'),
          new MyTile('11'),
          new MyTile('12'),
        ],
      ),
    ],
  ),
];







class Student{
  int tipoventa = 1;
  String restaurante = "F35";
  //String accion = "post";


  Student({
    this.tipoventa,
    this.restaurante,
    //this.accion,

  });

  factory Student.fromJson(Map<String, dynamic> parsedJson){
    return Student(
      tipoventa : parsedJson ['tipoventa'],
      restaurante: parsedJson['restaurante'],
      //accion : parsedJson['accion'],

    );
  }
}

/*
_enviarProducto() async {
  final response = await http.post(
    Uri.https('jsonplaceholder.typicode.com', 'albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'title': 'pereuraa',
    }),
  );
  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return response.body;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}*/





