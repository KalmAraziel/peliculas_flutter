import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {
  
  String _apiKey = '1fbcb2e6f389bf06f8a33141e1fcfd52';
  String _url= 'api.themoviedb.org';
  String _lenguaje = 'es-ES';
 
  Future <List<Pelicula>> getEnCines() async {    
    Peliculas peliculas = new Peliculas();
    final url = Uri.http(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _lenguaje
    });

    var response = await http.get(url);

    if (response.statusCode == 200) {
      // decodifico la data
      var decodedData = convert.jsonDecode(response.body);    
      peliculas = new Peliculas.fromJsonList(decodedData['results']);      
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return peliculas.items;

  }
}