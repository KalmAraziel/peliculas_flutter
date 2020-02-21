import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  
  final List<Pelicula> peliculas;
  final Function siguientePagina;
  MovieHorizontal({ @required this.peliculas, @required this.siguientePagina });

  final _pageController = new PageController(
    initialPage: 1,
    viewportFraction: 0.3
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener( () {
      if  (_pageController.position.pixels >= _pageController.position.maxScrollExtent - 200 ) {
        print('cargar siguientes peliculas');
        siguientePagina();
      }
    });

    return Container(
      child: Container(
        height: _screenSize.height * 0.2,
        child: PageView.builder(
          itemCount: peliculas.length,
          pageSnapping: false,
          controller: _pageController,
          itemBuilder: (contex, i ) {
            return _tarjeta(context, peliculas[i]);
          }
        ),
      ),
    );
  }


  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    final tarjeta =  Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'), 
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.17
              ),
            ),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    return GestureDetector(
      onTap: () { 
        Navigator.pushNamed(context, '/detalle', arguments: pelicula);
      },
      child: tarjeta,
    );
  }

  List<Widget>_tarjetas(context) {
    return peliculas.map((pelicula) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'), 
                image: NetworkImage(pelicula.getPosterImg()),
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.18
              ),
            ),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  }
}