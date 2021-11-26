enum ObjectType {
  type_category,
  type_product,
  type_subproduct,
}

class clMenu {
  int? vP_ID;
  String? bodE_NOMBRE;
  String? puntO_VENTA;
  String? categoria;
  String? codigo;
  String? codigO_ALIADO;
  String? producto;
  String? grupo;
  String? item;
  int? precio;
  String? foto;
  String identifier = "";
  String? name;
  String? parentName;
  bool canBeExpanded = false;
  bool isExpanded = false;
  int? level;
  int? type;

  List<clMenu> children = <clMenu>[];
  ObjectType? objectType;


  clMenu(vP_ID, bodE_NOMBRE, puntO_VENTA, categoria, codigo, codigO_ALIADO, producto, grupo, item, precio, foto){
    this.vP_ID = vP_ID;
    this.bodE_NOMBRE = bodE_NOMBRE;
    this.puntO_VENTA = puntO_VENTA;
    this.categoria = categoria;
    this.codigo = codigo;
    this.codigO_ALIADO = codigO_ALIADO;
    this.producto = producto;
    this.grupo = grupo;
    this.item = item;
    this.precio = precio;
    this.foto = foto;

  }

}