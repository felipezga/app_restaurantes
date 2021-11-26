import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:restaurantes_tipoventas_app/Modelos/AgrupacionMenu.dart';
import 'package:restaurantes_tipoventas_app/Modelos/clMenu.dart';
import 'package:restaurantes_tipoventas_app/Servicios/ProductoServicio.dart';

import 'Producto_event.dart';
import 'Producto_state.dart';

class ProductoBloc extends Bloc<ProductoEvent, ProductoState> {
  //final TextFieldType type;
  ProductoBloc() : super(ProductoInitial());

  @override
  Stream<ProductoState> mapEventToState(ProductoEvent event) async* {
    /*try {
      yield* event.applyAsync(currentState: state, bloc: this);
    } catch (_, stackTrace) {
      developer.log('$_', name: 'ProductoBloc', error: _, stackTrace: stackTrace);
      yield state;
    }*/
    if (event is ListarProductos) {

      print("entramos a bloc");
      yield ProductoLoading();

      try {
        ProductoServ apiService = new ProductoServ();

        List<clMenu> productos = await apiService.listarProducto(event.categoria);
        //User dataUsuario = await AuthAPIServicio.Producto( event.email, event.password);
        //authenticationBloc.add(LoggedIn(token: token));

        List<Agrupacion>  salida = await apiService.Agrupar(productos);
        //salida = [];
        yield ProductoFinishedState( salida: salida);



      } catch (error) {
        yield ErrorProductoState(error.toString());
      }
    }

    if (event is EnviarProducto) {

      ProductoServ apiService = new ProductoServ();

      var productos = await apiService.enviarProducto( event.data);
      print("salida producto");

      List<Agrupacion> salida = [];
      yield ProductoFinishedState( salida: salida);
    }
/*
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
        yield ProductoFinishedState();
      } else {
        yield ErrorProductoState("invalidCredential");
      }
    } catch (_, stackTrace) {
      developer.log('$_',
          name: 'LoadProductoEvent', error: _, stackTrace: stackTrace);
      yield ErrorProductoState(_?.toString());
    }*/
  }

}
