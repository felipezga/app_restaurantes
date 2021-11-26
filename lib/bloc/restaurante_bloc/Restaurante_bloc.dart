import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:restaurantes_tipoventas_app/Modelos/SalidaModel.dart';
import 'package:restaurantes_tipoventas_app/Modelos/clRestaurante.dart';
import 'package:restaurantes_tipoventas_app/Servicios/RestauranteServicio.dart';

import 'Restaurante_event.dart';
import 'Restaurante_state.dart';

class RestauranteBloc extends Bloc<RestauranteEvent, RestauranteState> {
  //final TextFieldType type;
  RestauranteBloc() : super(RestauranteInitial());

  @override
  Stream<RestauranteState> mapEventToState(RestauranteEvent event) async* {
    /*try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'RestauranteBloc', error: _, stackTrace: stackTrace);
      yield state;
    }*/
    if (event is ListarRestaurantes) {

      print("entramos a bloc");
      yield RestauranteLoading();

      try {
        RestauranteServ apiService = new RestauranteServ();

        Salida salida = await apiService.listarRestaurantes();
        print(salida);
        //User dataUsuario = await AuthAPIServicio.Restaurante( event.email, event.password);
        //authenticationBloc.add(LoggedIn(token: token));

        if(salida.code != 0 ){
            yield RestauranteFinishedState( salida: salida);
        }else {
          yield ErrorRestauranteState(salida.message.toString());
          //yield RestauranteInitial();
        }


      } catch (error) {
        yield ErrorRestauranteState(error.toString());
      }
    }

    if( event is FiltrarRestaurante){
      List<clRestaurante> filteredRestaurantes = [];

      print(event.restaurantes.length);

      print("ggggg_  " + event.data);
      print(event.data);
        filteredRestaurantes = event.restaurantes
            .where((r) => r.bodE_NOMBRE!.toLowerCase().contains(event.data.toLowerCase())).toList();

        print(filteredRestaurantes);
        print(filteredRestaurantes.length);
        Salida salida = Salida(1, "", []);
        salida.restaurante = filteredRestaurantes;


      yield RestauranteFinishedState( salida: salida );

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
      final password = UserSession.allUsers[this.userName];
      if (password == this.password) {
        UserSession.setLoggedIn();
        yield RestauranteFinishedState();
      } else {
        yield ErrorRestauranteState("invalidCredential");
      }
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadRestauranteEvent', error: _, stackTrace: stackTrace);
      yield ErrorRestauranteState(_?.toString());
    }*/
  }

}
