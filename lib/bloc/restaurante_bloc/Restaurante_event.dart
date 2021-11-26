import 'package:restaurantes_tipoventas_app/Modelos/clRestaurante.dart';

abstract class RestauranteEvent{}

class ListarRestaurantes extends RestauranteEvent {
  ListarRestaurantes();
}


class FiltrarRestaurante extends RestauranteEvent {
  final String data;
  final List<clRestaurante> restaurantes;

  FiltrarRestaurante({required this.data, required this.restaurantes});


}