import 'dart:convert';
import 'package:my_movies/model/dto/movie_dto.dart';

MovieDto movieDtoFromJson(String str) => MovieDto.fromJson(json.decode(str));

String movieDtoToJson(MovieDto data) => json.encode(data.toJson());