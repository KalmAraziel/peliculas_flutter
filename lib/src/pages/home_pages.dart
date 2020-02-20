import 'package:flutter/material.dart';

import 'package:peliculas/src/widgets/card_swiper_widget.dart';

import 'package:peliculas/src/providers/peliculas_provider.dart';

class HomePage extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {            
    
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
          children: <Widget>[
            _swiperTarjetas()
          ],
        )
      )
    );
  }

  Widget _swiperTarjetas() {
    final peliProvider = PeliculasProvider();
    peliProvider.getEnCines();
    return CardSwiper(peliculas: [1,2,3,4,5]);
  }
}


 
