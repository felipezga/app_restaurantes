import 'package:restaurantes_tipoventas_app/Modelos/clTipoVenta.dart';

abstract class TipoVentaState  {
  TipoVentaState();
}

class TipoVentaDefaultState extends TipoVentaState {
  TipoVentaDefaultState() : super();

  @override
  String toString() => 'RestauranteDefaultState';
}

class ErrorTipoVentaState extends TipoVentaState {
  final String? errorMessage;

  ErrorTipoVentaState(this.errorMessage);

  @override
  String toString() => 'ErrorRestauranteState';
}



class TipoVentaFinishedState extends TipoVentaState {
  final Future<List<clTipoVenta>>? listaTipoVentaRest;

  TipoVentaFinishedState({ this.listaTipoVentaRest});
}

class TipoVentaLoading extends TipoVentaState {}

class TipoVentaInitial extends TipoVentaState {}

