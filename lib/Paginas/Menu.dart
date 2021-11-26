import 'package:flutter/material.dart';
import 'package:restaurantes_tipoventas_app/widgets/CategoriaWidget.dart';

class Menu extends StatelessWidget {

  final String? id;
  String? restaurante;
   Menu({Key? key, this.id, this.restaurante}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: new Text(id!),),
      body: MenuLista(id : id, restaurante: restaurante ),
      backgroundColor:Colors.yellow[700],
    );
  }

}

class MenuLista extends StatefulWidget{
  String? id;
  String? restaurante;
  MenuLista({this.id, this.restaurante}) : super();

  _MenuState createState() => _MenuState();

}

class _MenuState extends State<MenuLista> {
  String? _TipoVenta;
  String? _Restaurante;

  void initState() {
    super.initState();
    _TipoVenta = 10.toString();
    _Restaurante = widget.restaurante;
    //_TipoVenta = widget.id;
  }

  Widget build(BuildContext context) {
    return
      Stack(
        children: <Widget>[
          SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                       Text("Categorias",
                            textAlign: TextAlign.center,
                            style: appTitle,
                          ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                              child: categoryWidget( context,  'frisby',  'Promociones', "Promociones")
                          ),
                          SizedBox(width: 20,),
                          Flexible(
                              child: categoryWidget( context,  'pollo',  'Pollo Apanado', "Pollo" )
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                              child: categoryWidget( context,  'pollo_bbq',  'Pollo BBQ', "BBQ")
                          ),
                          SizedBox(width: 20,),
                          Flexible(
                              child: categoryWidget( context,  'frisdelicias',  'Frisdelicias', "Frisdelicias")
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                              child: categoryWidget( context,  'combos',  'Combos', "Combos")
                          ),
                          SizedBox(width: 20,),
                          Flexible(
                              child: categoryWidget( context,  'liviana',  'Linea Liviana', "Linea Liviana")
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                              child: categoryWidget( context,  'frisby_kids',  'Frisby Kids', "FrisbyKids")
                          ),
                          SizedBox(width: 20,),
                          Flexible(
                              child: categoryWidget( context,  'acompanamiento',  'Acompañamientos', "Acompañamientos")
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Flexible(
                              child: categoryWidget( context,  'bebida',  'Bebidas', "Bebidas")
                          ),
                          SizedBox(width: 20,),
                          Flexible(
                              child: Text("")
                          )
                        ],
                      ),
                    ],
                  ),
                )
              )
          )
        ]

    );

  }

}


const appTitle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    height: 1.5
);
const appSubTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    height: 1.5
);


