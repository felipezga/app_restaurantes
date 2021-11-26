import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:restaurantes_tipoventas_app/Modelos/clTipoVenta.dart';
import 'package:restaurantes_tipoventas_app/Servicios/tipoVentaServicio.dart';

import 'tipoVenta_event.dart';
import 'tipoVenta_state.dart';

class TipoVentaBloc extends Bloc<TipoVentaEvent, TipoVentaState> {
  //final TextFieldType type;
  TipoVentaBloc() : super(TipoVentaInitial());

  @override
  Stream<TipoVentaState> mapEventToState(TipoVentaEvent event) async* {
    /*try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'RestauranteBloc', error: _, stackTrace: stackTrace);
      yield state;
    }*/
    if (event is ListarTiposVenta) {

      print("entramos a bloc");
      yield TipoVentaLoading();

      try {
        TipoVentaServ apiService = new TipoVentaServ();

        Future<List<clTipoVenta>> tiposVenta =  apiService.listarTipoVenta(event.idRest);
        //User dataUsuario = await AuthAPIServicio.Restaurante( event.email, event.password);
        //authenticationBloc.add(LoggedIn(token: token));

        yield TipoVentaFinishedState( listaTipoVentaRest: tiposVenta);


      } catch (error) {
        yield ErrorTipoVentaState(error.toString());
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
