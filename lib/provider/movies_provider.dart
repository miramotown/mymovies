import 'dart:async';

import 'package:my_movies/model/dto/movie_dto.dart';
import 'package:my_movies/model/dto/trending_dto.dart';
import 'package:my_movies/model/rest/movie_detail_response.dart';
import 'package:my_movies/model/rest/popular_movies_response.dart';
import 'package:my_movies/model/rest/trending_movies_response.dart';
import 'package:my_movies/provider/api/api_trakt.dart';
import 'package:http/http.dart' as http;

class MoviesProvider{

  bool _loading     = false;
  int _trendingPage = 0;
  int _limitPage    = 10;

  List<TrendingDto> _trendingList = [];

  final _trendingStreamController = StreamController<List<TrendingDto>>.broadcast();

  Function(List<TrendingDto>) get trendingSink => _trendingStreamController.sink.add;
  Stream<List<TrendingDto>> get trendingStream => _trendingStreamController.stream;

  void disposeStreams(){
    _trendingStreamController.close();
  }


  Future<List<TrendingDto>> getTrending() async {
    if(_loading){
      return [];
    }
    _loading = true;
    _trendingPage++;
    print('MoviesProvider() - getTrending() - loading page $_trendingPage');
    final uri = Uri.https(ApiTrakt.urlBase, 'movies/trending', {
      'page' : _trendingPage.toString(),
      'limit': _limitPage.toString(),
    });
    var response = await http.get(uri, headers: ApiTrakt.headers);
    List<TrendingDto> trendingLoad = [];
    if(response.statusCode == 200){
      final listTrending = trendingMoviesDtoFromJson(response.body);
      trendingLoad = listTrending;
      _trendingList.addAll(listTrending);
      trendingSink(_trendingList);
      _loading = false;
    }
    return trendingLoad;
  }

  Future<List<MovieDto>> getPopular() async {
    final uri = Uri.https(ApiTrakt.urlBase, 'movies/popular');
    var response = await http.get(uri, headers: ApiTrakt.headers);
    List<MovieDto> popularLoad = [];
    if(response.statusCode == 200){
      final listPopular = popularMoviesDtoFromJson(response.body);
      popularLoad = listPopular;
    }
    return popularLoad;
  }

  static getMovieDetail(String slug) async {
    final uri = Uri.https(ApiTrakt.urlBase, 'movies/$slug', {
      'extended' : "full",
    });
    var response = await http.get(uri, headers: ApiTrakt.headers);
    return (response.statusCode == 200) ? movieDtoFromJson(response.body) : null;
  }

}