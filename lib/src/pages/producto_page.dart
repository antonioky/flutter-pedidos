import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pedimosya/src/models/producto_model.dart';
import 'package:pedimosya/src/providers/productos.provider.dart';
import 'package:pedimosya/src/utils/utils.dart' as utils;
//import 'package:image_picker/image_picker.dart';

class ProductoPage extends StatefulWidget {
 
  @override
  _ProductoPageState createState() => _ProductoPageState();
}

class _ProductoPageState extends State<ProductoPage> {
 final formKey=GlobalKey<FormState>();
 final scaffoldKey=GlobalKey<ScaffoldState>();
 final productoProvider=new ProductosProvider();
 ProductoModel producto=new ProductoModel();
 bool _guardando=false;

 File foto;



  @override
  Widget build(BuildContext context) {

    final ProductoModel prodData=ModalRoute.of(context).settings.arguments;
    if(prodData !=null){
      producto=prodData;
    }
    return Scaffold(
      key:scaffoldKey,
      appBar: AppBar(
        title: Text('Producto'),
        actions: <Widget>[
          IconButton(
            icon:Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: (){},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                 _crearDisponible(),
                _crearBoton(),
               
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre(){
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration:InputDecoration(
        labelText: 'Producto'
      ),
      onSaved: (value)=>producto.titulo=value,
      validator: (value){
        if(value.length<3){
          return 'Ingrese el nombre del producto';
        }else{
          return null;
        }
      },
    );
  }

  Widget _crearPrecio(){
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.number,
      decoration:InputDecoration(
        labelText: 'Precio'
      ),
      onSaved: (value)=>producto.valor=double.parse(value),
      validator: (value){
        if (utils.isNumeric(value)){
          return null;
        }
        else{
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _crearDisponible(){
    return SwitchListTile(
      value: producto.disponible,
      title: Text('Disponible'),
      activeColor: Colors.deepPurple,
      onChanged: (value)=>setState((){
        producto.disponible=value;
      }),
    );
  }

   Widget _crearBoton(){
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      color: Colors.deepPurple,
      textColor: Colors.white,
      label: Text('Guardar'),
      icon:Icon(Icons.save),
      onPressed: (_guardando) ? null : _submit,
    );
    
  }

  void _submit(){
    if(!formKey.currentState.validate()) return;

    formKey.currentState.save();
   
    setState(() {
      _guardando=true;
    });

    if(producto.id == null){
      productoProvider.crearProducto(producto);
    }else{
      productoProvider.editarProducto(producto);
    }

    mostrarSnackbar('Registro Guardado');
    
    /*setState(() {
      _guardando=false;
    });*/
    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje){

    final snackbar =SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  Widget _mostrarFoto(){
    if(producto.fotoUrl != null)
    {
      return Container();
    }else{
      return Image(
        image: AssetImage(foto?.path ?? 'assets/no-image.png'),
        height: 300.0,
        fit:BoxFit.cover,
      );
    }
  }

  _seleccionarFoto() async{
    foto=await ImagePicker.pickImage(
      source: ImageSource.gallery
    );
    if(foto !=null){

    }
    setState(() {});
  }
}