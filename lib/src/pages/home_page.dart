import 'package:flutter/material.dart';
import 'package:pedimosya/src/models/producto_model.dart';
import 'package:pedimosya/src/providers/productos.provider.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

final productosProvider=new ProductosProvider();

   
  @override
  Widget build(BuildContext context) {

    
    return Scaffold(
      appBar: AppBar(
        title: Text('Pollos Kiki'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: _crearListado(),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado(){
    return FutureBuilder(
      future: productosProvider.cargarProductos(),
      builder: (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot){
        if(snapshot.hasData){
          final productos = snapshot.data;
          return ListView.builder(
            itemCount: productos.length,
            itemBuilder: (context,i)=>_crearItem(context,productos[i]),
          );
        }
        else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

   Widget _crearItem(BuildContext context,ProductoModel producto){
     return Dismissible(
       key: UniqueKey(),
       background: Container(
         color: Colors.red,
       ),
       onDismissed: (direccion){
         //borrar producto
         productosProvider.borrarProducto(producto.id);
       },
            child: Card(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Image(
                      image:AssetImage('assets/kiki1.jpg'),
                      fit:BoxFit.cover
                      ),
                  ),
                  ListTile(
                  title: Text('${producto.titulo}-${producto.valor}'),
                  subtitle: Text(producto.id),
                  onTap: ()=>Navigator.pushNamed(context, 'producto',arguments: producto)
                  )
                ],
              ),
            )
     );

    /* ListTile(
         title: Text('${producto.titulo}-${producto.valor}'),
         subtitle: Text(producto.id),
         onTap: ()=>Navigator.pushNamed(context, 'producto',arguments: producto),
       ),*/
  }

  _crearBoton(BuildContext context){
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Colors.deepPurple,
      onPressed: ()=>Navigator.pushNamed(context, 'producto'),
    );
  }
}