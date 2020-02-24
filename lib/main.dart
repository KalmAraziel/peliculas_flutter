import 'package:flutter/material.dart';

import 'package:peliculas/src/pages/home_pages.dart';
import 'package:peliculas/src/pages/pelicula_detalle.dart';

 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PeliculasApp',
      initialRoute: '/',
      routes: {
        '/' : ( BuildContext context ) => HomePage(),
        '/detalle': (BuildContext context) => PeliculaDetalle()
      },
    );
  }
}