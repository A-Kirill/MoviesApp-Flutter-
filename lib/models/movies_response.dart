import 'package:json_annotation/json_annotation.dart';
part 'movies_response.g.dart';

@JsonSerializable()
class ApiMoviesQuery {
  ApiMoviesQuery({
  required this.items,
  });

  List<Movie> items;

  factory ApiMoviesQuery.fromJson(Map<String, dynamic> json) =>
      _$ApiMoviesQueryFromJson(json);

  Map<String, dynamic> toJson() => _$ApiMoviesQueryToJson(this);
}

@JsonSerializable()
class Movie {
  Movie({
    required this.kinopoiskId,
    this.nameRu,
    this.nameEn,
    this.nameOriginal,
    this.ratingKinopoisk,
    this.year,
    this.description,
    required this.posterUrl,
    required this.posterUrlPreview,
    this.countries,
    this.genres,
    this.duration,
    this.premiereRu,
  });

  int kinopoiskId;
  String? nameRu;
  String? nameEn;
  String? nameOriginal;
  double? ratingKinopoisk;
  int? year;
  String? description;
  String posterUrl;
  String posterUrlPreview;
  List<Country>? countries;
  List<Genre>? genres;
  int? duration;
  DateTime? premiereRu;

  //Computed properties:
  String get getCountries {
    return countries?.map((obj) => obj.country).toList().join(', ') ?? '';
  }

  String get getGenres {
    return genres?.map((obj) => obj.genre).toList().join(', ') ?? '';
  }

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
  Map<String, dynamic> toJson() => _$MovieToJson(this);
}

@JsonSerializable()
class Country {
  Country({
    required this.country,
  });

  String country;

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);
  Map<String, dynamic> toJson() => _$CountryToJson(this);
}

@JsonSerializable()
class Genre {
  Genre({
    required this.genre,
  });

  String genre;

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
  Map<String, dynamic> toJson() => _$GenreToJson(this);
}

