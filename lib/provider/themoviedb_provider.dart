import 'package:my_movies/model/dto/movie_dto.dart';
import 'package:my_movies/model/rest/themoviedb_response.dart';
import 'package:my_movies/provider/api/api_tmdb.dart';
import 'package:http/http.dart' as http;

class TheMovieDbProvider{

  static getTheMovieDbInfo(MovieDto movieDto) async {
    Uri uri = Uri.https(ApiTmdb.urlBase, '3/find/'+movieDto.movieId!.imdb!, {
      'api_key' : ApiTmdb.apiKey,
      'external_source': ApiTmdb.externalSource,
      'language': ApiTmdb.language,
    });
    var response = await http
        .get(uri, headers: ApiTmdb.headers)
        .timeout(Duration(seconds: 10));
    print('getPosterPath() -> '+response.body);
    return theMovieDbResponseFromJson(response.body);
  }

}