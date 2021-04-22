import 'package:flutter/material.dart';
import 'package:restaurantes_tipoventas_app/Paginas/Producto.dart';

Container categoriaHomeWidget(BuildContext context, String img, String title, String route)
{
  return Container(
    margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
    width: MediaQuery.of(context).size.width*0.3,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(30)),
        boxShadow: [BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 20,
          spreadRadius: 1,
          offset: Offset(0,10),
        )]
    ),
    child: InkWell(
      onTap: (){
        //_CategoriaButtonPressed( context, '$title');
        Navigator.pushNamed(context, route);

      },
      child: Column(
        children: <Widget>[
          SizedBox(height: 20,),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('images/$img.png'),
                      fit: BoxFit.contain
                  )
              ),
            ),
          ),
          //SizedBox(height: 20,),
          Container(
            padding: EdgeInsets.all(20),
            child: Text('$title', style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10,)
        ],
      ),
    ),
  );
}


Container categoryWidget(BuildContext context, String img, String title, String route)
{
  return Container(
    width: double.infinity,
    height: 100,
    //width: 240,

    margin: EdgeInsets.only(left: 1, right: 1, bottom: 20),
    //width: MediaQuery.of(context).size.width*0.3,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
        boxShadow: [BoxShadow(
          color: Colors.black.withOpacity(0.5),
          blurRadius: 20,
          spreadRadius: 1,
          offset: Offset(0,10),
        )]
    ),

    child: InkWell(
        onTap: (){
          _CategoriaButtonPressed( context, '$route');

        },
        child: Column(
          children: <Widget>[
            /*Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15)
                ),
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text('$title', style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),*/
            Container(
              padding: EdgeInsets.all(5),
              child: Text('$title', style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/$img.png'),
                        fit: BoxFit.contain
                    )
                ),
              ),
            ),
            /*Positioned(
              right: -20,
              top: -10,
              child: Align(
                alignment: Alignment.topRight,
                child: Image.asset('images/$img.png'),
              ),
            )*/
          ],
        )
    ),
  );

}


void _CategoriaButtonPressed( BuildContext context, String categoria) {
  // Pushing a route directly, WITHOUT using a named route
  Navigator.of(context).push(
    // With MaterialPageRoute, you can pass data between pages,
    // but if you have a more complex app, you will quickly get lost.
    MaterialPageRoute(
      builder: (context) =>
          Productos(  categoria: categoria ),
      //TipoVentaRestaurante(opc: opc, id: id, data: nombre, descripcion: descripcion),
    ),
  );

}

