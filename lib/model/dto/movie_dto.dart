import 'package:my_movies/model/dto/movie_id_dto.dart';

class MovieDto {
  MovieDto({
    this.title,
    this.year,
    this.movieId,
    this.tagline,
    this.overview,
    this.released,
    this.runtime,
    this.country,
    this.trailer,
    this.homepage,
    this.status,
    this.rating,
    this.votes,
    this.commentCount,
    this.updatedAt,
    this.language,
    this.availableTranslations,
    this.genres,
    this.certification,
  });

  String? title;
  int? year;
  MovieIdDto? movieId;
  String? tagline;
  String? overview;
  DateTime? released;
  int? runtime;
  String? country;
  String? trailer;
  String? homepage;
  String? status;
  double? rating;
  int? votes;
  int? commentCount;
  DateTime? updatedAt;
  String? language;
  List<String>? availableTranslations;
  List<String>? genres;
  String? certification;

  String posterPath = '';

  // Flag for Loading in background
  bool isProcess = true;

  factory MovieDto.fromJson(Map<String, dynamic> json) => MovieDto(
    title: json["title"] == null ? null : json["title"],
    year: json["year"] == null ? null : json["year"],
    movieId: json["ids"] == null ? null : MovieIdDto.fromJson(json["ids"]),
    tagline: json["tagline"] == null ? null : json["tagline"],
    overview: json["overview"] == null ? null : json["overview"],
    released: json["released"] == null ? null : DateTime.parse(json["released"]),
    runtime: json["runtime"] == null ? null : json["runtime"],
    country: json["country"] == null ? null : json["country"],
    trailer: json["trailer"] == null ? null : json["trailer"],
    homepage: json["homepage"] == null ? null : json["homepage"],
    status: json["status"] == null ? null : json["status"],
    rating: json["rating"] == null ? null : json["rating"].toDouble(),
    votes: json["votes"] == null ? null : json["votes"],
    commentCount: json["comment_count"] == null ? null : json["comment_count"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    language: json["language"] == null ? null : json["language"],
    availableTranslations: json["available_translations"] == null ? null : List<String>.from(json["available_translations"].map((x) => x)),
    genres: json["genres"] == null ? null : List<String>.from(json["genres"].map((x) => x)),
    certification: json["certification"] == null ? null : json["certification"],
  );

  Map<String, dynamic> toJson() => {
    "title": title == null ? null : title,
    "year": year == null ? null : year,
    "ids": movieId == null ? null : movieId!.toJson(),
    "tagline": tagline == null ? null : tagline,
    "overview": overview == null ? null : overview,
    "released": released == null ? null : "${released!.year.toString().padLeft(4, '0')}-${released!.month.toString().padLeft(2, '0')}-${released!.day.toString().padLeft(2, '0')}",
    "runtime": runtime == null ? null : runtime,
    "country": country == null ? null : country,
    "trailer": trailer == null ? null : trailer,
    "homepage": homepage == null ? null : homepage,
    "status": status == null ? null : status,
    "rating": rating == null ? null : rating,
    "votes": votes == null ? null : votes,
    "comment_count": commentCount == null ? null : commentCount,
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    "language": language == null ? null : language,
    "available_translations": availableTranslations == null ? null : List<dynamic>.from(availableTranslations!.map((x) => x)),
    "genres": genres == null ? null : List<dynamic>.from(genres!.map((x) => x)),
    "certification": certification == null ? null : certification,
  };

}