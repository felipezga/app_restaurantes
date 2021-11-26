import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:restaurantes_tipoventas_app/Modelos/clUsuarios.dart';
import 'package:restaurantes_tipoventas_app/Servicios/AuthAPI.dart';

import 'Login_event.dart';
import 'Login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  //final TextFieldType type;
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    /*try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'LoginBloc', error: _, stackTrace: stackTrace);
      yield state;
    }*/
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        AuthAPIServicio apiService = new AuthAPIServicio();

        User usuarioLogin = await apiService.login(event.email, event.password);
        print(usuarioLogin);
        //User dataUsuario = await AuthAPIServicio.login( event.email, event.password);
        //authenticationBloc.add(LoggedIn(token: token));

        if(usuarioLogin != null ){
          yield LoginInitial();

          if (usuarioLogin.token!.isNotEmpty) {
            yield LoginFinishedState();

          } else {
            yield ErrorLoginState(usuarioLogin.error?.toString());
            //yield LoginInitial();
          }
        }

        /*AuthAPIServicio apiService = new AuthAPIServicio();
                              apiService.login(event.email,event.password).then((value) {
                                if (value != null) {
                                  setState(() {
                                    isApiCallProcess = false;
                                  });

                                  if (value.token.isNotEmpty) {
                                    final snackBar = SnackBar(
                                        content: Text("Login Successful"));
                                    scaffoldKey.currentState
                                        .showSnackBar(snackBar);
                                    //Mapa();
                                    Navigator.pushReplacementNamed(context, '/mapa');
                                  } else {
                                    final snackBar =
                                    SnackBar(content: Text(value.error));
                                    scaffoldKey.currentState
                                        .showSnackBar(snackBar);
                                  }
                                }
                              });*/




      } catch (error) {
        yield ErrorLoginState(error.toString());
      }
    }

    /*if (event is AppStarted) {
      final bool hasToken = await userRepository.hasToken();

      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      yield AuthenticationLoading();
      await userRepository.persistToken(event.token);
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }*/

    /*try {
      yield LoginStartingState();
      final password = UserSession.allUsers[this.userName];
      if (password == this.password) {
        UserSession.setLoggedIn();
        yield LoginFinishedState();
      } else {
        yield ErrorLoginState("invalidCredential");
      }
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadLoginEvent', error: _, stackTrace: stackTrace);
      yield ErrorLoginState(_?.toString());
    }*/
  }

  @override
  LoginState get initialState => LoginDefaultState();
}
