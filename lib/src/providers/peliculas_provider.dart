import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {

  String _apiKey = '1fbcb2e6f389bf06f8a33141e1fcfd52';
  String _url= 'api.themoviedb.org';
  String _lenguaje = 'es-ES';

  Future <List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _lenguaje
    });



    // final resp = await http.get(url);
    final decodedData = json.decode(resp.body);

    print(decodedData);
  }
}