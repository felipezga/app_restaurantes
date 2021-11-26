
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurantes_tipoventas_app/widgets/drawer.dart';
import 'package:restaurantes_tipoventas_app/widgets/CategoriaWidget.dart';

class PaginaHome extends StatelessWidget{
  static const String route = '/';
  const PaginaHome({Key? key}) : super(key: key);

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(" APP RESTAURANTES",
            style: TextStyle(
                fontSize: 22,
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
            //color: Colors.blue,
          color: Colors.yellow[700],
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
            Container(
              height: 80,
              //color: Colors.blueGrey,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(4),
              child: Text("Bienvenido \n  ", style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w700
              ),),
            ),
            //SizedBox(height: 10,),
            Expanded(
              child: GridView.count(crossAxisCount: 2,
                childAspectRatio: 0.85,
                children: <Widget>[
                  categoriaHomeWidget(context, 'menu_frisby', "Menus  ", "/restaurantemenu"),
                  categoriaHomeWidget(context, 'frisby', "Tipos de Venta", "/restaurante"),
                ],
              ),
            ),
          ],
        ),
      ),


    );

  }

}

