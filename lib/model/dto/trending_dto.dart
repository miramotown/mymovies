import 'package:my_movies/model/dto/movie_dto.dart';

class TrendingDto {
  TrendingDto({
    this.watchers,
    this.movie,
  });

  int? watchers;
  MovieDto? movie;

  // Flag for Loading in background
  bool isProcess = true;


  factory TrendingDto.fromJson(Map<String, dynamic> json) => TrendingDto(
    watchers: json["watchers"] == null ? null : json["watchers"],
    movie: json["movie"] == null ? null : MovieDto.fromJson(json["movie"]),
  );

  Map<String, dynamic> toJson() => {
    "watchers": watchers == null ? null : watchers,
    "movie": movie == null ? null : movie!.toJson(),
  };
}