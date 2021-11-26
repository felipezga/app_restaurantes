import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantes_tipoventas_app/Modelos/clRestaurante.dart';
import 'package:restaurantes_tipoventas_app/bloc/CambioEstados_bloc/CambioEstado_bloc.dart';
import 'package:restaurantes_tipoventas_app/bloc/CambioEstados_bloc/CambioEstado_event.dart';
import 'package:restaurantes_tipoventas_app/bloc/CambioEstados_bloc/CambioEstado_state.dart';
import 'package:restaurantes_tipoventas_app/bloc/restaurante_bloc/Restaurante_bloc.dart';
import 'package:restaurantes_tipoventas_app/bloc/restaurante_bloc/Restaurante_event.dart';
import 'package:restaurantes_tipoventas_app/bloc/restaurante_bloc/Restaurante_state.dart';
import 'TipoVenta_Restaurante.dart';


class Restaurante extends StatelessWidget {
  static const String route = '/restaurante';
  final int? opcion;

  Restaurante({ Key? key,    this.opcion }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      MultiBlocProvider(
        providers: [
          BlocProvider(
          create: (context) => RestauranteBloc(),
          ),
          BlocProvider(
            create: (context) => CambioEstadoBloc(),
          )
        ],
        child: Scaffold(
          body: MyHomePage(title: ' RESTAURANTES', opcion : opcion),
        ),
      );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title, this.opcion}) : super(key: key);

  final String? title;
  final int? opcion;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  bool isSwitched = false;
  bool buscador = false;
  List<clRestaurante> Restaurantes = [];
  List<clRestaurante>  filteredRestaurantes = [];

  late RestauranteBloc restauranteBloc;
  late CambioEstadoBloc cambioEstadoBloc;

  static  int? opc;

  @override
  void initState(){
    super.initState();

    opc = widget.opcion;
    print('Este es: ');
    print(opc);

    restauranteBloc = BlocProvider.of<RestauranteBloc>(context);
    //cambioEstadoBloc = BlocProvider.of<CambioEstadoBloc>(context);
    cambioEstadoBloc = context.read<CambioEstadoBloc>();

    restauranteBloc.add(ListarRestaurantes());
    cambioEstadoBloc.add( CambiarEstado( false) );

    /*_getRestaurante().then((value) {
      setState(() {
        filteredRestaurantes = value;
      });
    });*/

  }

  @override
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    //_controller.dispose();
    restauranteBloc.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return
      BlocBuilder<RestauranteBloc, RestauranteState>(
          builder: (BuildContext context, RestauranteState state) {
            if (state is ErrorRestauranteState) {

              final error = state.errorMessage;
              String message = error! + '\nTap to Retry.';
              return Text(message);
            }
            if (state is RestauranteFinishedState) {
              print("entramos full");

              filteredRestaurantes = state.salida.restaurante;
              return Scaffold(
                appBar: PreferredSize(
                  child: MyAppBar( cambioEstadoBloc, restauranteBloc, filteredRestaurantes ),
                  preferredSize: Size.fromHeight(56),
                ),
                body: Container(
                  padding: EdgeInsets.all(10),
                  child: _status(filteredRestaurantes),
                ),
                backgroundColor:Colors.yellow[700],
              );

            }
            if (state is RestauranteLoading) {
              return Scaffold(
                appBar: PreferredSize(
                  child: MyAppBar( cambioEstadoBloc, restauranteBloc, filteredRestaurantes ),
                  preferredSize: Size.fromHeight(56),
                ),
                body: Container(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
                backgroundColor:Colors.yellow[700],
              );
            }
            else{
              return Scaffold(
                appBar: PreferredSize(
                  child: MyAppBar( cambioEstadoBloc, restauranteBloc, filteredRestaurantes ),
                  preferredSize: Size.fromHeight(56),
                ),
                body: Container(
                  padding: EdgeInsets.all(10),
                  child: Center(
                    child: Text("Inconvenientes"),
                  ),
                ),
                backgroundColor:Colors.yellow[700],
              );
            }
          });
  }


  _status(filteredRestaurantes){
    if (filteredRestaurantes.length > 0) {
      return ListView.builder(
          itemCount: filteredRestaurantes.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                  /*Navigator.of(context).pushNamed(Country.routeName,
                      arguments: filteredRestaurantes[index]);*/
                  _onSearchButtonPressed(opc,
                      filteredRestaurantes[index].vbR_ID,
                      filteredRestaurantes[index].bodE_NOMBRE,
                      filteredRestaurantes[index].bodE_DESCRIPCION);
                  },
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Text(
                      filteredRestaurantes[index].bodE_DESCRIPCION!,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
            );
          });
    }else{
        return Center(child: Text("No hay restaurantes..."));
      }

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
                  child : Text(item.bodE_NOMBRE!) ,
                  ),
                  new IconButton(
                    icon: new Icon(Icons.restaurant),
                    highlightColor: Colors.pink,
                    onPressed: (){_onSearchButtonPressed(opc, item.vbR_ID , item.bodE_NOMBRE, item.bodE_DESCRIPCION);},
                  ),
                ],
              ),
            ],
          ),
        )
      );
    }

    return restaurantes;
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


class MyAppBar extends StatelessWidget with PreferredSizeWidget {
  CambioEstadoBloc cambioEstadoBloc;
  RestauranteBloc restauranteBloc;
  final List<clRestaurante>  filteredRestaurantes;

  MyAppBar(this.cambioEstadoBloc, this.restauranteBloc, this.filteredRestaurantes);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CambioEstadoBloc, CambioEstadoState>(
        builder: (BuildContext context, CambioEstadoState state)  {
          print("state cambio");
          print(state);
          if (state is CambioEstadoFinishedState) {
            print("estado buscador");

            var buscador = state.salida;
            print(buscador);
            if (buscador == false) {
              return AppBar(
                title: Text("RESTAURANTES", style: TextStyle(
                  //fontSize: 25,
                  //color: Theme.of(context).primaryColor,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                )),
                actions: [
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        context.read<CambioEstadoBloc>().add( CambiarEstado( true) );

                         //cambioEstadoBloc.add( CambiarEstado(data: true) );
                         print("buscar");
                      }),
                ],

              );
            } else {
              return AppBar(
                  title: TextField(
                    onChanged: (value) {
                      print("filtrar");
                      print(value);
                       restauranteBloc.add(FiltrarRestaurante(data: value, restaurantes: filteredRestaurantes));
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
                    IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        print("cancelar");
                        context.read<CambioEstadoBloc>().add( CambiarEstado(false) );
                        restauranteBloc.add(ListarRestaurantes());
                      },
                    )
                  ]
              );
            }
          }

           else {
            return AppBar(title: Text("que maria"),);
          }
        }
    );

  }

  @override
  //Size get preferredSize => Size(appbarwidth, appbarheight);
  Size get preferredSize => Size.fromHeight(56);
}
