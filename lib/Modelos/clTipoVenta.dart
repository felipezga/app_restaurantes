class clTipoVenta{
  int  tipoventa_id;
  int  restaurante_id;
  String descripcion_tp;
  String estado;
  bool switched;

  clTipoVenta( tipoventa_id, restaurante_id, descripcion_tp, estado, switched ){
    this.tipoventa_id = tipoventa_id;
    this.restaurante_id = restaurante_id;
    this.descripcion_tp = descripcion_tp;
    this.estado = estado;
    this.switched = switched;
  }
}