import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:restaurantes_tipoventas_app/Servicios/NotificacionesPush.dart';
import 'package:restaurantes_tipoventas_app/widgets/drawer.dart';
import 'package:restaurantes_tipoventas_app/widgets/CategoriaWidget.dart';


import 'Restaurante.dart';

class PaginaHome extends StatelessWidget{
  static const String route = '/';
  const PaginaHome({Key key}) : super(key: key);

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(" APP RESTAURANTES",
            style: TextStyle(
                fontSize: 25,
                //color: Theme.of(context).primaryColor,
                color: Colors.black,
                fontWeight: FontWeight.bold
            )
        ),
        //backgroundColor: Colors.yellow
      ),
      drawer: buildDrawer(context, route),
      body:
      //HomePage()
      Container(
        padding: EdgeInsets.only(
            top: 30,
            bottom: 10,
            right: 10,
            left: 10
        ),
        decoration: BoxDecoration(
          //color: Colors.yellow[700],
          image: DecorationImage(
            alignment: Alignment.bottomLeft,
            image: AssetImage('images/icono_frisby.png'),
            /*NetworkImage(
                "https://ges-sas.co/wp-content/uploads/frisby2.jpg"
                   // "https://lh3.googleusercontent.com/proxy/0ZjFOCbFyJnSvhDWeJATGMYgi6c05cZyhPqxEjkRF2f2BA998ISvA_zrZT2-4gg9CWezO0Es5nHWg-dO7_nNmlZ7lc9ErqJeZdlK8Y0D6NB53ZszxHGB1KY"
            ),*/
          )
        ),
        child: Column(
          children: <Widget>[
            //SizedBox(height: 100,),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(10),
              child: Text("Hola \nFelipe Rios", style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700
              ),),
            ),
            SizedBox(height: 60,),
            Expanded(
              child: GridView.count(crossAxisCount: 2,
                childAspectRatio: 0.85,
                children: <Widget>[
                  categoriaHomeWidget(context, 'menu_frisby', "Menus  ", "/restaurantemenu"),
                  categoriaHomeWidget(context, 'frisby', "Tipos de Venta", "/restaurante"),
                ],
              ),
            ),

                /*Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: RaisedButton(
                            color: Colors.white,
                            shape: new RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            onPressed: () {
                              Navigator.pushNamed(context, "/restaurantemenu");
                              },
                            child: SizedBox(
                              width: 100,
                              height: 100,
                              child: Center(
              child: Column( // Replace with a Row for horizontal icon + text
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Icon(Icons.menu , size: 40,),
                  Text("MENU",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        //color: Colors.indigo,
                        fontWeight: FontWeight.w900
                    ),

                  ),
                ],
              ),
            ),
          ),
        ),
      )
      ],
    ),
    Column(
    children: <Widget>[
    Padding(
    padding: EdgeInsets.all(10),
    child: RaisedButton(
    color: Colors.white,
    shape: new RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0)),
    onPressed: () {Navigator.pushNamed(context, "/restaurante");},
    child: SizedBox(
    width: 100,
    height: 100,
    child: Center(
      child: Column( // Replace with a Row for horizontal icon + text
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(Icons.apps , size: 40,),
          Text("TIPO VENTA",
            textAlign: TextAlign.center,
            style: TextStyle(
                //color: Colors.indigo,
                fontWeight: FontWeight.w900
            ),
          ),
        ],
      ),

    ),
    ),
    ),
    )
    ],
    ),
    ],
    ),*/


    ],
    ),
    ),




    );

  }

}

