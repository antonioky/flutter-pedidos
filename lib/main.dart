import 'package:flutter/material.dart';
import 'package:pedimosya/src/bloc/provider_bloc.dart';
import 'package:pedimosya/src/pages/home_page.dart';
import 'package:pedimosya/src/pages/login_page.dart';
import 'package:pedimosya/src/pages/producto_page.dart';
import 'package:pedimosya/src/pages/registro_page.dart';
import 'package:pedimosya/src/preferencias_usuario/preferencias_usuario.dart';
 
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();

  runApp(MyApp());
    
  }
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final prefs = new PreferenciasUsuario();
    print(prefs.token);

    return Provider(
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'login',
      routes: {
        'login':(BuildContext context)=>LoginPage(),
        'home':(BuildContext context)=>HomePage(),
        'producto':(BuildContext context)=>ProductoPage(),
        'registro':(BuildContext context)=>RegistroPage(),
      },
      theme: ThemeData(
        primaryColor: Colors.deepPurple
      ),
     
    )

    );
    
  }
}