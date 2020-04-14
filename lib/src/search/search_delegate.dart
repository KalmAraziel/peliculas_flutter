import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';

class DataSearch extends SearchDelegate {
  String  peliculaSeleccionada = '';
  final peliculas  = ['Batman', 'Resident Evil', 'The Legend of Zelda', 'The last of Us'];
  final peliculasRecientes = ['Batman 2', 'Resident Evil 2'];
  
  final peliculasProvider = new PeliculasProvider();
  
  @override
  List<Widget> buildActions(BuildContext context) {
    // Acciones del appBar limpiar o cerrar
    return [
      IconButton(
        icon: Icon(Icons.clear), 
        onPressed: () {
          query= '';

        }
      )
    ]; 
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icono a la izquierda del appbar
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ), 
        onPressed: () { 
          // cerrar modal busqueda
          close(context, null); 
        },
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que se mostraran
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if(query.isEmpty) {
      return Container();
    }
    return FutureBuilder(
      future: peliculasProvider.buscarPelicula(query),
      builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
        if(snapshot.hasData){
          final  peliculas = snapshot.data;
          return ListView(
            children: peliculas.map( (pel) {
              return ListTile(
                leading: FadeInImage(
                  placeholder: AssetImage('assets/no-image.jpg'), 
                  image: NetworkImage(pel.getPosterImg()),
                  width: 50,
                  fit: BoxFit.contain
                ),
                title: Text(pel.title),
                subtitle: Text(pel.originalTitle),
                onTap: () {
                  // close(context, null);
                  pel.uniqueId = '';
                  print('pelicula: ' + pel.toString());
                  Navigator.of(context).pushNamed('/detalle',  arguments: pel);
                  //Navigator.pushNamed(context, '/detalle', arguments: pel);
                  // 
                },
              );
            }).toList()
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        
      },
    );
    
  }
  
  /*
  @override
  Widget buildSuggestions(BuildContext context) {
    final listaBusquedaSugerida = ( query.isEmpty ) 
                                    ? peliculasRecientes 
                                    : peliculas.where( 
                                        (p) => p.toLowerCase().startsWith(query.toLowerCase() ) 
                                      ).toList();
    return  ListView.builder(
      itemCount: listaBusquedaSugerida.length,
      itemBuilder: (context, i) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(listaBusquedaSugerida[i]),
          onTap: () {  
            peliculaSeleccionada = listaBusquedaSugerida[i]; 
          },
        );
      },
    );
  }
 */
}