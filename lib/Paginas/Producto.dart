import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantes_tipoventas_app/Modelos/AgrupacionMenu.dart';
import 'package:restaurantes_tipoventas_app/Modelos/clMenu.dart';
import 'package:restaurantes_tipoventas_app/bloc/producto_bloc/Producto_bloc.dart';
import 'package:restaurantes_tipoventas_app/bloc/producto_bloc/Producto_event.dart';
import 'package:restaurantes_tipoventas_app/bloc/producto_bloc/Producto_state.dart';

class Productos extends StatefulWidget{
  String? categoria;
  Productos({ this.categoria});

  _ProductosState createState() => _ProductosState();
}


class _ProductosState extends State<Productos>{

  //String url = "http://10.0.2.2:5000/api/restaurante/F35/55/";
  //String url = "https://10.0.2.2:5001/api/restaurante/F33/55/";
  List<clMenu> Menu = [];
  String? categoria;
  List<Agrupacion> _ListaProductos = [];
  late ProductoBloc _myBloc;

  @override
  void initState(){
    super.initState();
    categoria =widget.categoria;
    _myBloc = ProductoBloc()..add(ListarProductos( categoria!));

  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoria!),
      ),
      body: BlocProvider<ProductoBloc>(
        create: (context) => _myBloc,
        child: BlocBuilder<ProductoBloc, ProductoState>(
            builder: (BuildContext context, ProductoState state) {
              if (state is ErrorProductoState) {
                final error = state.errorMessage;
                String message = error! + '\nTap to Retry.';
                return Text(message);
              }
              if (state is ProductoFinishedState) {
                print("entramos full");
                _ListaProductos = state.salida;
                return new ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return new ExpansionProductos(_ListaProductos[index]);
                  //return new StuffInTiles(listOfTiles[index]);
                  },
                  itemCount: _ListaProductos.length,
                );
              }else{
                return Center(
                  child: CircularProgressIndicator() ,
                );
              }
            }),
      ),
      backgroundColor: Colors.yellow[700],
    );
  }
}


class ExpansionProductos extends StatefulWidget {
   Agrupacion productos;
   ExpansionProductos(this.productos);

   ExpansionProductosState createState() => ExpansionProductosState();
}


class ExpansionProductosState extends State<ExpansionProductos>{

  late ProductoBloc ProdBloc;
  late  Agrupacion agrupProductos;

  @override
  void initState(){
    super.initState();

    ProdBloc = BlocProvider.of<ProductoBloc>(context);
    agrupProductos = widget.productos;

  }


  @override
  Widget build(BuildContext context) {
    return _buildTiles(agrupProductos);
  }

  Widget _buildTiles(Agrupacion t) {
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
          title: new Text(t.title!)
      );

    return
     (t.image == '') ?  new ExpansionTile(
       //key: new PageStorageKey<int>(3),
       backgroundColor: Colors.black12,
       title: Row(
         mainAxisAlignment: MainAxisAlignment.spaceBetween,
         children: [
           Expanded(
             child: new Text(t.title!),
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
                          onPressed: (){
                          ProdBloc.add(EnviarProducto(data: "hola"));
                          },
                        ),
                        Image.network("https://wsres.vensis.com.co/wsapp/product/"+t.image!, width: 90, height: 90),
                      ],
                    )
             ),
             Expanded(
               child: new Text(t.title!),
             ),
           ],
         ),
         children: t.children.map(_buildTiles).toList(),
       );
  }

}