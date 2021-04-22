import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(

            //Image(image: AssetImage('images/icono_frisby2.png')),
            /*child: Image.asset(
              'images/icono_frisby2.png',
              width: 200.0,
              height: 140.0,
              //fit: BoxFit.cover,
            ),*/
        child: Text('Restaurantes Frisby', style: TextStyle(
            fontSize: 35,
            //color: Theme.of(context).primaryColor,
            color: Colors.white,
            fontWeight: FontWeight.bold
        )),

        //Text('Frisby'),
      ),
    );
  }
}