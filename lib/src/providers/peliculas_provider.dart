import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider {
  
  String _apiKey = '1fbcb2e6f389bf06f8a33141e1fcfd52';
  String _url= 'api.themoviedb.org';
  String _lenguaje = 'es-ES';
  int _popularesPage = 0;

  List<Pelicula> _populares = new List();
  
  final _popularesStreamCtrl = StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink => _popularesStreamCtrl.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamCtrl.stream;


  void disposeStream () {
    _popularesStreamCtrl?.close();
  }

  Future <List<Pelicula>> _procesarRespuesta(Uri url) async {
    Peliculas peliculas = new Peliculas();
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

  Future <List<Pelicula>> getEnCines() async {    
    
    final url = Uri.http(_url, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _lenguaje
    });
    return _procesarRespuesta(url);

  }

  Future <List<Pelicula>> getPopulares() async {    
    
    _popularesPage ++;

    final url = Uri.http(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _lenguaje,
      'page': _popularesPage.toString()
    });

    final respuesta = await _procesarRespuesta(url);
    _populares.addAll(respuesta);
    popularesSink(_populares);
    return respuesta;
  }
}