import 'dart:convert';

import 'package:my_movies/model/dto/movie_tmdb_dto.dart';

TheMovieDbResponse theMovieDbResponseFromJson(String str) => TheMovieDbResponse.fromJson(json.decode(str));

String theMovieDbResponseToJson(TheMovieDbResponse data) => json.encode(data.toJson());

class TheMovieDbResponse {
  TheMovieDbResponse({
    this.movieResults,
    this.personResults,
    this.tvResults,
    this.tvEpisodeResults,
    this.tvSeasonResults,
  });

  List<MovieTmdbDto>? movieResults;
  List<dynamic>? personResults;
  List<dynamic>? tvResults;
  List<dynamic>? tvEpisodeResults;
  List<dynamic>? tvSeasonResults;

  factory TheMovieDbResponse.fromJson(Map<String, dynamic> json) => TheMovieDbResponse(
    movieResults: json["movie_results"] == null ? null : List<MovieTmdbDto>.from(json["movie_results"].map((x) => MovieTmdbDto.fromJson(x))),
    personResults: json["person_results"] == null ? null : List<dynamic>.from(json["person_results"].map((x) => x)),
    tvResults: json["tv_results"] == null ? null : List<dynamic>.from(json["tv_results"].map((x) => x)),
    tvEpisodeResults: json["tv_episode_results"] == null ? null : List<dynamic>.from(json["tv_episode_results"].map((x) => x)),
    tvSeasonResults: json["tv_season_results"] == null ? null : List<dynamic>.from(json["tv_season_results"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "movie_results": movieResults == null ? null : List<dynamic>.from(movieResults!.map((x) => x.toJson())),
    "person_results": personResults == null ? null : List<dynamic>.from(personResults!.map((x) => x)),
    "tv_results": tvResults == null ? null : List<dynamic>.from(tvResults!.map((x) => x)),
    "tv_episode_results": tvEpisodeResults == null ? null : List<dynamic>.from(tvEpisodeResults!.map((x) => x)),
    "tv_season_results": tvSeasonResults == null ? null : List<dynamic>.from(tvSeasonResults!.map((x) => x)),
  };
}


