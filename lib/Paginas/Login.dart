import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurantes_tipoventas_app/bloc/login_bloc/Login_bloc.dart';
import 'package:restaurantes_tipoventas_app/bloc/login_bloc/Login_event.dart';
import 'package:restaurantes_tipoventas_app/bloc/login_bloc/Login_state.dart';

import 'Home.dart';
//import 'package:gametv/Modules/Authentication/Bloc/index.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key key}) : super(key: key);

  static const String route = '/login';

  @override
  Widget build(BuildContext context) {
    print("provider");
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          //color:  Colors.red,
          child: CustomScrollView(
            reverse: true,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50.0,
                    ),
                    Image.asset('images/frisby_homepage.png'),
                    Expanded(
                      child: BlocProvider(
                        create: (BuildContext context) => LoginBloc(),
                        child: LoginBuilder(),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );

    /*return BlocProvider(
      create: (BuildContext context) => LoginBloc(),
      child: LoginBuilder(),
    );*/
  }
}

class LoginBuilder extends StatefulWidget {
  const LoginBuilder({Key key}) : super(key: key);

  @override
  _LoginBuilderState createState() => _LoginBuilderState();
}

class _LoginBuilderState extends State<LoginBuilder> {
  bool hidePassword = true;
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    print("builder");

    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(email: _userNameController.text, password: _passwordController.text));
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        print("listener");
        if (state is LoginFinishedState) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => PaginaHome()),
              (Route<dynamic> route) => false);
        }else if (state is ErrorLoginState) {
          /*final snackBar = SnackBar(content: Text(state.errorMessage));
          scaffoldKey.currentState.showSnackBar(snackBar);*/
        print("Es aquiddd");
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(state.errorMessage),
            duration: Duration(seconds: 3),
          ));
        }
      },
      //bloc: BlocProvider.of<LoginBloc>(context),

      child: Stack(
        children: <Widget>[
          BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return Card(
                //color: Colors.blue,
                  //padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  //margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                  margin: const EdgeInsets.all(20),
                  elevation: 10.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),

                  child: Container(
                  //padding: EdgeInsets.all(15),
                  margin: EdgeInsets.all(15),
                  height: 280,
                  child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                            child: Text(
                              "APP RESTAURANTES",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                        ),
                        SizedBox(height: 10.0),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Documento',
                          ),
                          controller: _userNameController,
                        ),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Clave',
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                              color: Theme.of(context)
                                  .accentColor
                                  .withOpacity(0.4),
                              icon: Icon(hidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                          controller: _passwordController,
                          obscureText: hidePassword,
                        ),

                        SizedBox(
                          height: 10.0,
                        ),
                        /*LoginButton(
                            userName: this._userNameController.text,
                            password: this._passwordController.text,
                          )*/
                        Padding(
                          padding: EdgeInsets.only(top: 30.0, bottom: 20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(

                                  height: 45,
                                  child: state is LoginLoading
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Center(
                                                child: Column(

                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 25.0,
                                                  width: 25.0,
                                                  child: CircularProgressIndicator()
                                                )
                                              ],
                                            ))
                                          ],
                                        )
                                      : RaisedButton(
                                          color: Colors.red,
                                          disabledColor: Colors.blueAccent,
                                          disabledTextColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                          ),
                                          onPressed: _onLoginButtonPressed,
                                          child: Text("INGRESAR",
                                              style: new TextStyle(
                                                  fontSize: 12.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                //)
              );
            },
            //bloc: BlocProvider.of<LoginBloc>(context),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    this._userNameController.dispose();
    this._passwordController.dispose();
    super.dispose();
  }
}
