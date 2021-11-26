import 'dart:io';
import 'package:flutter/material.dart';
import 'package:restaurantes_tipoventas_app/Modelos/clUsuarios.dart';
import 'Paginas/Home.dart';
import 'Paginas/Inicio.dart';
import 'Paginas/Login.dart';
import 'Paginas/Restaurante.dart';
import 'Servicios/UserSession.dart';

//void main() => runApp(App());

// firebase cloud messaging
/*
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}*/

Future<void> main() async {
  // firebase cloud messaging
  /*
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);*/

  HttpOverrides.global = new MyHttpOverrides();
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<App> {
  Future<User>? _session;

  List<Widget> paginas = [
    PaginaHome(),
    Restaurante(),
  ];

  @override
  void initState() {
    _session = UserSession().getUser();
    print(_session);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(_session);
    print("Hola");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),

      //home: paginas[_paginaActual],
      home: FutureBuilder(

        future: _session,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          print("Snap");
          print(snapshot);
          /*if (snapshot.hasData && snapshot.data != null) {

            print(snapshot.data);
            print("data");
            return snapshot.data ? PaginaHome() : LoginScreen();


          } else if (snapshot.hasError && snapshot.error != null) {
            return Center(
              child: Text(snapshot.error),
            );
          } else {
            print("loginscreen");
            return LoginScreen();
          }*/

          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
                return SplashPage();
              //return CircularProgressIndicator();
            default:
              if (snapshot.hasError)
                return Text('Error: ${snapshot.error}');
              else if (snapshot.data.token == null)
                //return LoginScreen();
                return PaginaHome();
              else
                //UserPreferences().removeUser();
              //return Welcome(user: snapshot.data);
              return PaginaHome();
          }
        },

      ),
      //initialRoute: "/",
      routes: <String, WidgetBuilder>{
        //"/" : (context) => Login();
        LoginScreen.route: (context) => LoginScreen(),
        "/restaurantemenu": (context) => Restaurante(opcion: 1),
        Restaurante.route: (context) => Restaurante(opcion: 2),
        //"/contacto" : ( context) => Contacto(),
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
