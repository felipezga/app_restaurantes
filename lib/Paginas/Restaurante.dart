import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurantes_tipoventas_app/Modelos/clRestaurante.dart';
import 'package:http/http.dart' as http;

import 'TipoVenta_Restaurante.dart';


class Restaurante extends StatelessWidget {
  // This widget is the root of your application.
  static const String route = '/restaurante';

  final int opcion;

  Restaurante({ Key key,    this.opcion }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      //appBar: AppBar(title: new Text("CONTACTO"),),
      body: MyHomePage(title: ' RESTAURANTES', opcion : opcion),
    );

    /*return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: ' Restaurantes', opcion : opcion),
    );*/
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.opcion}) : super(key: key);

  final String title;
  final int opcion;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool isSwitched = false;
  bool buscador = false;
  List<clRestaurante> Restaurantes = [];
  List<clRestaurante>  filteredRestaurantes = [];
  //String url = "http://10.0.2.2:5000/api/restaurante";
  String url = "https://10.0.2.2:5001/api/restaurante";

  //Future<List<clRestaurante>> _ListaRestaurante;
  //List<clRestaurante> _ListaRestaurante;

/*Future<List<clRestaurante>> _getRestaurante() async{
    final response = await http.get(url);
    if(response.statusCode == 200 ){
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      for(var item in jsonData ){
        Restaurantes.add(clRestaurante( item["vbR_ID"], item["bodE_NOMBRE"], item["bodE_DESCRIPCION"]));
      }
      return Restaurantes;
    }else{
      throw Exception("Fallo la conexion");
    }
  }
 */
    _getRestaurante() async {
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


  static  int opc;

  @override
  void initState(){
    super.initState();
    //_ListaRestaurante = _getRestaurante();

    opc = widget.opcion;
    print('Este es: ');
    print(opc);

    _getRestaurante().then((value) {
      setState(() {
        filteredRestaurantes = value;
      });
    });


  }

  void _filterRest(value) {

    print(value);
    print(filteredRestaurantes);
    print('BEBE1');

    setState(() {
      filteredRestaurantes = Restaurantes
          .where((r) => r.bodE_NOMBRE.toLowerCase().contains(value.toLowerCase())).toList();
    });



    print(filteredRestaurantes);
    print('BEBE2');
  }


  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: !buscador?
        Text(widget.title, style: TextStyle(
            //fontSize: 25,
            //color: Theme.of(context).primaryColor,
            color: Colors.black,
            fontWeight: FontWeight.bold
        )) :
        TextField(
          onChanged: (value) {
            _filterRest(value);
          },
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: "Busca el restaurante aqui",
              hintStyle: TextStyle(color: Colors.white)),
        ),
        actions: [
          buscador
              ? IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              setState(() {
                this.buscador = false;
                //filteredCountries = countries;
              });
            },
          ) :
          IconButton(
              icon: Icon(Icons.search),
              onPressed: (){
                setState(() {
                  this.buscador = true;
                });
              }),
          
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: filteredRestaurantes.length > 0
            ? ListView.builder(
            itemCount: filteredRestaurantes.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  /*Navigator.of(context).pushNamed(Country.routeName,
                      arguments: filteredRestaurantes[index]);*/
                  _onSearchButtonPressed(opc, filteredRestaurantes[index].vbR_ID , filteredRestaurantes[index].bodE_NOMBRE, filteredRestaurantes[index].bodE_DESCRIPCION);
                },
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Text(
                      filteredRestaurantes[index].bodE_DESCRIPCION,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              );
            })
            : Center(
          child: CircularProgressIndicator(),
        ),
      ),

      /*FutureBuilder(
        future: _ListaRestaurante,
        builder: (context, snapshot){
          if(snapshot.hasData){
            //print(snapshot.data);
            return ListView(
              children: _listRest(snapshot.data),
            );
          }else if(snapshot.hasError){
            //print(snapshot.error);
            return Text("Error");
          }

          return Center(child: CircularProgressIndicator(),);
        },

      ),*/
      /*Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              onPressed: (){},
              child: Text('CLick me'),
                color: Colors.blue
            ),
            Icon(
              Icons.add_to_photos,
              color: Colors.deepOrange,
              size: 50,
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),

          ],
        ),

      ),*/
      backgroundColor:Colors.yellow[700],
      /*floatingActionButton: FloatingActionButton(
        //onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
        backgroundColor:Colors.blue,
      ), // This trailing comma makes auto-formatting nicer for build methods.
       */
    );
  }

  List<Widget> _listRest( List<clRestaurante> data){
    List<Widget> restaurantes = [];
    for( var item in data){
      restaurantes.add(

        Card(
          child:
          Column(
            children: [
              Row(
                children: [
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child : Text(item.bodE_NOMBRE) ,
                  ),
                  new IconButton(
                    icon: new Icon(Icons.restaurant),
                    highlightColor: Colors.pink,
                    onPressed: (){_onSearchButtonPressed(opc, item.vbR_ID , item.bodE_NOMBRE, item.bodE_DESCRIPCION);},
                  ),
                  /*Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                        print(isSwitched);
                      });
                    },
                    activeTrackColor: Colors.lightGreenAccent,
                    activeColor: Colors.green,
                  ),*/
                ],
              ),
            ],
          ),
        )

      );
    }

    return restaurantes;
  }

  _ontap(){
    print("hola");
  }

  _onLongPress(data){
    print(data);
  }

  void _onSearchButtonPressed(opc, id, nombre, descripcion) {
    print(nombre);
      // Pushing a route directly, WITHOUT using a named route
      Navigator.of(context).push(
        // With MaterialPageRoute, you can pass data between pages,
        // but if you have a more complex app, you will quickly get lost.
        MaterialPageRoute(
          builder: (context) =>
              TipoVentaRestaurante(opc: opc, id: id, data: nombre, descripcion: descripcion),
        ),
      );

  }
}
