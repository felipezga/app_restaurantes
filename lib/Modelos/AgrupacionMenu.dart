class Agrupacion {
  String? title;
  String? image;
  //List<Agrupacion> children;
  List<Agrupacion> children = <Agrupacion>[];
  //Agrupacion(this.title, [this.children = const <Agrupacion>[]]);
  Agrupacion(this.title, this.image, this.children);
}
