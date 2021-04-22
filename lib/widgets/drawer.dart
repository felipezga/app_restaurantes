import 'package:flutter/material.dart';
import 'package:restaurantes_tipoventas_app/Paginas/Login.dart';
import 'package:restaurantes_tipoventas_app/Paginas/Restaurante.dart';
import 'package:restaurantes_tipoventas_app/Servicios/UserSession.dart';



//import '../Paginas/prueba.dart';

Drawer buildDrawer(BuildContext context, String currentRoute) {
  return Drawer(
    child: Column(
        mainAxisAlignment: MainAxisAlignment
            .spaceBetween, // place the logout at the end of the drawer
        children: <Widget>[
    Flexible(
      child: ListView(
          //shrinkWrap: true,
          children: <Widget>[
            /*DrawerHeader(
          child: Center(
            child: const Text('Felipe Rios'),
          ),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),*/
            _createHeader(),

            ListTile(
              leading: Icon(Icons.person),
              title: const Text('Perfil'),
              //selected: currentRoute == Mapa.route,
              onTap: () {
                Navigator.popAndPushNamed(context, Restaurante.route);
                //  Navigator.pushReplacementNamed(context, Mapa.route);
              },
            ),
            //Divider(),
            ListTile(
              leading: Icon(Icons.restaurant_menu_rounded),
              title: const Text('Restaurantes'),
              //selected: currentRoute == Restaurante.route,
              onTap: () {
                //Navigator.pushReplacementNamed(context, Restaurante.route);
                Navigator.popAndPushNamed(context, Restaurante.route);
              },
            ),
            Divider(),

          ]
      )
      ),

          ListTile(
            leading: Icon(Icons.arrow_back_sharp),
            title: const Text('Salir'),
            dense: true,
            //selected: currentRoute == Restaurante.route,
            onTap: () {
              //Navigator.pushReplacementNamed(context, Restaurante.route);
              UserSession().removeUser();
              Navigator.pushNamed(context, LoginScreen.route);
            },
          ),

          ]

    ),
  );
}


Widget _createHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          /*image: DecorationImage(
              fit: BoxFit.fitWidth,
              image:  AssetImage('images/icono_frisby.png')),*/
        color: Colors.yellow[700],
      ),
      child: Stack(children: <Widget>[
        Positioned(
            bottom: 8.0,
            left: 12.0,
            child:
            Text(
                "Felipe Rios",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w500,
                ))),

         Image.asset('images/icono_frisby.png'),
      ]));
}
