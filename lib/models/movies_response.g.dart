// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiMoviesQuery _$ApiMoviesQueryFromJson(Map<String, dynamic> json) =>
    ApiMoviesQuery(
      items: (json['items'] as List<dynamic>)
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ApiMoviesQueryToJson(ApiMoviesQuery instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      kinopoiskId: json['kinopoiskId'] as int,
      nameRu: json['nameRu'] as String?,
      nameEn: json['nameEn'] as String?,
      nameOriginal: json['nameOriginal'] as String?,
      ratingKinopoisk: (json['ratingKinopoisk'] as num?)?.toDouble(),
      year: json['year'] as int?,
      description: json['description'] as String?,
      posterUrl: json['posterUrl'] as String,
      posterUrlPreview: json['posterUrlPreview'] as String,
      countries: (json['countries'] as List<dynamic>?)
          ?.map((e) => Country.fromJson(e as Map<String, dynamic>))
          .toList(),
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
          .toList(),
      duration: json['duration'] as int?,
      premiereRu: json['premiereRu'] == null
          ? null
          : DateTime.parse(json['premiereRu'] as String),
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'kinopoiskId': instance.kinopoiskId,
      'nameRu': instance.nameRu,
      'nameEn': instance.nameEn,
      'nameOriginal': instance.nameOriginal,
      'ratingKinopoisk': instance.ratingKinopoisk,
      'year': instance.year,
      'description': instance.description,
      'posterUrl': instance.posterUrl,
      'posterUrlPreview': instance.posterUrlPreview,
      'countries': instance.countries,
      'genres': instance.genres,
      'duration': instance.duration,
      'premiereRu': instance.premiereRu?.toIso8601String(),
    };

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      country: json['country'] as String,
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'country': instance.country,
    };

Genre _$GenreFromJson(Map<String, dynamic> json) => Genre(
      genre: json['genre'] as String,
    );

Map<String, dynamic> _$GenreToJson(Genre instance) => <String, dynamic>{
      'genre': instance.genre,
    };
