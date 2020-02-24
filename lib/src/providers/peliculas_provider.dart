import 'dart:async';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/actores_model.dart';

import 'package:peliculas/src/models/pelicula_model.dart';


class PeliculasProvider {
  
  String _apiKey = '1fbcb2e6f389bf06f8a33141e1fcfd52';
  String _url= 'api.themoviedb.org';
  String _lenguaje = 'es-ES';
  int _popularesPage = 0;
  bool _cargando = false;

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
    
    if(_cargando) return [];

    _cargando = true;

    _popularesPage ++;

    final url = Uri.http(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _lenguaje,
      'page': _popularesPage.toString()
    });
    // print(url);
    final respuesta = await _procesarRespuesta(url);
    _populares.addAll(respuesta);
    popularesSink(_populares);
    _cargando  = false;
    return respuesta;
  }

  Future<List<Actor>> getCast(String idPelicula) async {
    Cast cast;
    final url = Uri.http(_url, '3/movie/$idPelicula/credits', {
      'api_key': _apiKey,
      'language': _lenguaje    
    });

    final response  = await http.get(url);
    if (response.statusCode == 200) {      
      // decodifico la data      
      var decodedData = convert.jsonDecode(response.body);    
      cast = new Cast.fromJsonList(decodedData['cast']);      
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    return cast.actores;
  }
}