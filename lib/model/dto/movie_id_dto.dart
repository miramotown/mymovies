class MovieIdDto {
  MovieIdDto({
    this.trakt,
    this.slug,
    this.imdb,
    this.tmdb,
  });

  int? trakt;
  String? slug;
  String? imdb;
  int? tmdb;

  factory MovieIdDto.fromJson(Map<String, dynamic> json) => MovieIdDto(
    trakt: json["trakt"] == null ? null : json["trakt"],
    slug: json["slug"] == null ? null : json["slug"],
    imdb: json["imdb"] == null ? null : json["imdb"],
    tmdb: json["tmdb"] == null ? null : json["tmdb"],
  );

  Map<String, dynamic> toJson() => {
    "trakt": trakt == null ? null : trakt,
    "slug": slug == null ? null : slug,
    "imdb": imdb == null ? null : imdb,
    "tmdb": tmdb == null ? null : tmdb,
  };
}