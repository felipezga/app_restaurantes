
abstract class ProductoEvent{}

class ListarProductos extends ProductoEvent {
  String categoria;
  ListarProductos( this.categoria);
}


class EnviarProducto extends ProductoEvent {
  final String data;
  //final List<clProducto> Productos;

  EnviarProducto({required this.data});

}