import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantes_tipoventas_app/Modelos/clTipoVenta.dart';
import 'package:restaurantes_tipoventas_app/bloc/tipoVenta_bloc/tipoVenta_bloc.dart';
import 'package:restaurantes_tipoventas_app/bloc/tipoVenta_bloc/tipoVenta_event.dart';
import 'package:restaurantes_tipoventas_app/bloc/tipoVenta_bloc/tipoVenta_state.dart';
import 'Menu.dart';

class TipoVentaRestaurante extends StatelessWidget {
  // This is a String for the sake of an example.
  // You can use any type you want.
  final int? opc;
  final int? id;
  final String? data;
  final String? descripcion;

  TipoVentaRestaurante({
    Key? key,
    this.opc,
    required this.id,
    required this.data,
    this.descripcion,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return
      MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TipoVentaBloc(),
          ),
          /*BlocProvider(
            create: (context) => CambioEstadoBloc(),
          )*/
        ],
        child: Scaffold(
          appBar: AppBar(
            title: Text(descripcion!),
          ),
          body: TipoVenta(opc:opc, id_restaurante: id, nombre: data),
          //backgroundColor:Colors.yellow[700],
        )
      );



  }
}

class TipoVenta extends StatefulWidget{
  final int? id_restaurante;
  final int? opc;
  final String? nombre;
  TipoVenta({Key? key, this.id_restaurante, this.opc, this.nombre}) : super(key: key);

  @override
  _TipoVentaState createState() => _TipoVentaState();
}

class _TipoVentaState extends State<TipoVenta> {

  late TipoVentaBloc tipoVentaBloc;
  bool isSwitched = false;
  bool? dynamicSwitch;
  late String myID;
  static int? _opc;
  String? _nombre;
  List<clTipoVenta> TipoVentasRestaurante = [];
  Future<List<clTipoVenta>>? _ListaTipoVentaRestaurante;
  final SwitchedTodos = clTipoVenta(0, 0, 'Todos los tipo de venta', 'A', false);

  @override
  void initState(){
    super.initState();

    myID = widget.id_restaurante.toString();
    _opc = widget.opc;
    _nombre = widget.nombre;

    tipoVentaBloc = BlocProvider.of<TipoVentaBloc>(context);

    tipoVentaBloc.add(ListarTiposVenta( myID ));
    //_myID = tipov.id_restaurante.toString();
    //_ListaTipoVentaRestaurante = _getTipoVenta();

  }



/*
  Future<List<clTipoVenta>> _getTipoVenta() async {

    //String url = "http://10.0.2.2:5000/api/restaurante/"+_myID;
    //String url = "https://10.0.2.2:5001/api/restaurante/"+_myID;

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

      return TipoVentasRestaurante;

    } else {
      print(response);
      throw Exception("Fallo la conexion");
    }
  }
*/

  @override
  Widget build(BuildContext context) {

    return
      BlocBuilder<TipoVentaBloc, TipoVentaState>(
    builder: (BuildContext context, TipoVentaState state) {
      if (state is ErrorTipoVentaState) {
        final error = state.errorMessage;
        String message = error! + '\nTap to Retry.';
        return Text(message);
      }
      if (state is TipoVentaFinishedState) {
        print("entramos full");

        _ListaTipoVentaRestaurante = state.listaTipoVentaRest;

        return FutureBuilder(
          future: _ListaTipoVentaRestaurante,
          builder: (context, snapshot){
            if(snapshot.hasData){
              //print(snapshot.data);
              if(_opc == 1)
                return  _listTipoVentaMenu(snapshot.data as List<clTipoVenta>, _nombre);
              return ListView(
                children: _listTipoVentaRest(snapshot.data as List<clTipoVenta>) ,
              );
            }else if(snapshot.hasError){
              //print(snapshot.error);
              return Text("Error");
            }else {
              return Center(
                child: CircularProgressIndicator() ,
              );
            }

          },

        );

        //filteredRestaurantes = state.salida.restaurante;
      }else{
        return Text("Sin estado");
      }
    });

  }
    
  Widget buildSwitchedTodos(
    @required clTipoVenta Todos
  ) =>
      SwitchListTile(
        title: Text(
          Todos.descripcion_tp!,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
          value: Todos.switched,
          onChanged: (value) =>  {
            setState(() {
            final newValue = !Todos.switched;
            SwitchedTodos.switched = newValue;
            TipoVentasRestaurante.forEach((notification) {
              notification.switched = newValue;
            });
            })
          },
      );



   _listTipoVentaRest( List<clTipoVenta> data)  {
    List<Widget> tipoventas = [];
    var i = 0;
    for (var item in data) {

      tipoventas.add(
        Column(children: [
          if(i == 0)
            buildSwitchedTodos(SwitchedTodos),
          SwitchListTile(
              //value: isSwitched,
              //value: dynamicSwitch != true ? isSwitched : dynamicSwitch,
              value: item.switched,
              title: Text(item.descripcion_tp!),
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,

              onChanged: (value){

                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Activar/Desactivar'),
                        content: Text("Estas seguro?"),
                        actions: <Widget>[
                          FlatButton(
                            color: Colors.red,
                            textColor: Colors.white,
                            child: Text('CANCELAR'),
                            onPressed: () {
                              setState(() {

                                Navigator.pop(context);

                              });
                            },
                          ),
                          FlatButton(
                            color: Colors.green,
                            textColor: Colors.white,
                            child: Text('OK'),
                            onPressed: () {
                              setState(() {
                              //codeDialog = valueText;

                                ////
                                isSwitched = value;
                                dynamicSwitch = value;

                                final newValue = !item.switched;
                                item.switched = newValue;
                                ////

                              Navigator.pop(context);
                              });
                            },
                          ),
                        ],
                      );
                    });
                  print(value);


/*
                  setState(() {
                      isSwitched = value;
                      dynamicSwitch = value;

                      final newValue = !item.switched;
                      item.switched = newValue;
                  });*/

                bebe(item.descripcion_tp);

          })
        , Divider()],)


      );

      i++;
    }

    return tipoventas;
  }

  _listTipoVentaMenu( List<clTipoVenta> data, String? nombre)  {
    List<Widget> tipoventas = [];

    return
      Container(
        padding: EdgeInsets.all(10),
    child: ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {

        /*return ListTile(
          title: item.buildTitle(context),
          subtitle: item.buildSubtitle(context),
        );*/

        return
          GestureDetector(
            onTap: () {
             // Navigator.pushNamed(context, "/menu");
          //Navigator.of(context).push("/menu",  id: data[index].descripcion_tp );
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    Menu( id: data[index].descripcion_tp, restaurante: nombre),
              ),
          );

          //_onSearchButtonPressed();
        },
          child: Card(
            color: Colors.yellow[700],
            elevation: 10,
          margin: EdgeInsets.all(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: 10, horizontal: 25),
            child: Text(
              data[index].descripcion_tp!,
              style: TextStyle(fontSize: 18),
            ),
          ),
          /*ListTile(
            //leading: Text(data[index].descripcion_tp),
            title: Text(data[index].descripcion_tp),
            //subtitle: Text(data[index].descripcion_tp),
          ),*/

          ),
        );
      },
    )
      );


  }

  void _onSearchButtonPressed() {
    print('eeeeee');
    // Pushing a route directly, WITHOUT using a named route
    /*Navigator.of(context).push(
      // With MaterialPageRoute, you can pass data between pages,
      // but if you have a more complex app, you will quickly get lost.
      MaterialPageRoute(
        builder: (context) =>
            TipoVentaRestaurante(opc: opc, id: id, data: nombre, descripcion: descripcion),
      ),
    );*/

  }

  bebe(data){
  print(data);
  }
}