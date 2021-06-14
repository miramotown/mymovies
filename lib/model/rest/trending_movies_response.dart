import 'dart:convert';

import 'package:my_movies/model/dto/trending_dto.dart';

List<TrendingDto> trendingMoviesDtoFromJson(String str) => List<TrendingDto>.from(json.decode(str).map((x) => TrendingDto.fromJson(x)));

String trendingMoviesDtoToJson(List<TrendingDto> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));




