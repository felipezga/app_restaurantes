abstract class CambioEstadoEvent{}

class CambiarEstado extends CambioEstadoEvent {
  final bool data;

  CambiarEstado(this.data);


}