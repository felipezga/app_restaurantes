import 'package:restaurantes_tipoventas_app/Modelos/clRestaurante.dart';

abstract class TipoVentaEvent{}

class ListarTiposVenta extends TipoVentaEvent {
  String idRest;
  ListarTiposVenta(this.idRest);
}


class FiltrarRestaurante extends TipoVentaEvent {
  final String data;
  final List<clRestaurante> restaurantes;

  FiltrarRestaurante({required this.data, required this.restaurantes});


}