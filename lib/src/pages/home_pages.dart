import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';


import 'package:peliculas/src/widgets/card_swiper_widget.dart';

import 'package:peliculas/src/providers/peliculas_provider.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
  
  final peliProvider = PeliculasProvider();

  @override
  Widget build(BuildContext context) {            
    peliProvider.getPopulares();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Peliculas en Cines"),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () { })
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context)
          ],
        )
      )
    );
  }

  Widget _swiperTarjetas() {        
    return FutureBuilder(
      future: peliProvider.getEnCines(),      
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }

        
        
      },
    );
  }

  Widget _footer(context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[   
          Container(
            child: Text('Populares' , style: Theme.of(context).textTheme.subhead),      
            padding: EdgeInsets.only(left: 20.0)
            ,
          ),           
          SizedBox(height: 5.0),

          StreamBuilder(
            stream: peliProvider.popularesStream,
                        
            builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(peliculas: snapshot.data, siguientePagina: peliProvider.getPopulares,);
              } else {
                return Center(child: CircularProgressIndicator());
              }              
            },
          ),
        ],
      ),
    );
  }
}


 
