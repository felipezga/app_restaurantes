abstract class CambioEstadoState {
  CambioEstadoState();
}

class CambioEstadoFinishedState extends CambioEstadoState {
  final bool salida;

  CambioEstadoFinishedState(this.salida);
}

class CambioEstadoInitial extends CambioEstadoState {}

