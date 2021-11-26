import 'package:restaurantes_tipoventas_app/Modelos/AgrupacionMenu.dart';

abstract class ProductoState  {
  ProductoState();
}

class ProductoDefaultState extends ProductoState {
  ProductoDefaultState() : super();

  @override
  String toString() => 'ProductoDefaultState';
}

class ErrorProductoState extends ProductoState {
  final String? errorMessage;

  ErrorProductoState(this.errorMessage);

  @override
  String toString() => 'ErrorProductoState';
}



class ProductoFinishedState extends ProductoState {
  //final String? message;
  final List<Agrupacion>  salida;

  ProductoFinishedState({required this.salida});
}

class ProductoLoading extends ProductoState {}

class ProductoInitial extends ProductoState {}

