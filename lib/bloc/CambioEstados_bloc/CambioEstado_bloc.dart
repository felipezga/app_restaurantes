import 'dart:async';
import 'package:bloc/bloc.dart';
import 'CambioEstado_event.dart';
import 'CambioEstado_state.dart';

class CambioEstadoBloc extends Bloc<CambioEstadoEvent, CambioEstadoState> {
  CambioEstadoBloc() : super(CambioEstadoInitial());

  @override
  Stream<CambioEstadoState> mapEventToState(CambioEstadoEvent event) async* {

    if( event is CambiarEstado){

      print("Vamos a cambiar esadi");

      yield (CambioEstadoFinishedState( event.data ));

    }
  }
}
