import 'package:restaurantes_tipoventas_app/Modelos/SalidaModel.dart';

abstract class RestauranteState  {
  RestauranteState();
}

class RestauranteDefaultState extends RestauranteState {
  RestauranteDefaultState() : super();

  @override
  String toString() => 'RestauranteDefaultState';
}

class ErrorRestauranteState extends RestauranteState {
  final String? errorMessage;

  ErrorRestauranteState(this.errorMessage);

  @override
  String toString() => 'ErrorRestauranteState';
}



class RestauranteFinishedState extends RestauranteState {
  //final String? message;
  final Salida salida;

  RestauranteFinishedState({required this.salida});
}

class RestauranteLoading extends RestauranteState {}

class RestauranteInitial extends RestauranteState {}

