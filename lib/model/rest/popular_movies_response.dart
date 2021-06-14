import 'dart:convert';

import 'package:my_movies/model/dto/movie_dto.dart';

List<MovieDto> popularMoviesDtoFromJson(String str) => List<MovieDto>.from(json.decode(str).map((x) => MovieDto.fromJson(x)));

String popularMoviesDtoToJson(List<MovieDto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
