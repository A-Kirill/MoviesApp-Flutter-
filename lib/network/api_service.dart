import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:movies_fltr/models/images_response.dart';
import 'package:movies_fltr/models/movies_response.dart';
import 'package:movies_fltr/auth//secrets.dart';
import '../models/video_response.dart';

class ApiService {
  final String baseUrl = 'https://kinopoiskapiunofficial.tech/api/v2.2/films/';
  final String premier = 'premieres';
  final String images = '/images';
  final String videos = '/videos';

  Future<List<Movie>> getPremiers(
      {required String month, required String year}) async {
    final queryPremierParameters = {
      'year': year,
      'month': month,
    };

    Uri uri = Uri.parse(baseUrl + premier);
    final finalUri = uri.replace(queryParameters: queryPremierParameters);

    http.Response result =
        await http.get(finalUri, headers: {'X-API-KEY': apiKey});

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(utf8.decode(result.bodyBytes));
      final moviesMap = jsonResponse['items'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      List<Movie> typedMovies = List<Movie>.from(movies.whereType<Movie>());
      return typedMovies;
    } else {
      throw Exception('Failed to getPremiers');
    }
  }

  Future<Movie> getMovieDetailsBy(int id) async {
    Uri uri = Uri.parse(baseUrl + id.toString());

    http.Response result = await http.get(uri, headers: {'X-API-KEY': apiKey});

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(utf8.decode(result.bodyBytes));
      Movie movie = Movie.fromJson(jsonResponse);
      return movie;
    } else {
      throw Exception('Failed to getMovieDetailsBy $id');
    }
  }

  Future<List<Images>> getImagesFor(int id) async {
    Uri uri = Uri.parse(baseUrl + id.toString() + images);

    http.Response result = await http.get(uri, headers: {'X-API-KEY': apiKey});

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(utf8.decode(result.bodyBytes));
      final imagesMap = jsonResponse['items'];
      List images = imagesMap.map((i) => Images.fromJson(i)).toList();
      List<Images> typedImages = List<Images>.from(images.whereType<Images>());
      return typedImages;
    } else {
      throw Exception('Failed to getImagesFor $id');
    }
  }

  Future<List<Video>> getVideoFor(int id) async {
    Uri uri = Uri.parse(baseUrl + id.toString() + videos);

    http.Response result = await http.get(uri, headers: {'X-API-KEY': apiKey});

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(utf8.decode(result.bodyBytes));
      final imagesMap = jsonResponse['items'];
      List videos = imagesMap.map((i) => Video.fromJson(i)).toList();
      List<Video> typedVideos = List<Video>.from(videos.whereType<Video>());
      List<Video> sortVideos = typedVideos.where((e) => e.url.contains('yout')).toList();
      return sortVideos;
    } else {
      throw Exception('Failed to getVideoFor $id');
    }
  }

  Future<List<Movie>> getSearchedMovies(String name) async {
    Uri uri = Uri.parse(baseUrl);
    final finalUri = uri.replace(queryParameters: {"keyword": name});

    http.Response result =
        await http.get(finalUri, headers: {'X-API-KEY': apiKey});

    if (result.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(utf8.decode(result.bodyBytes));
      final moviesMap = jsonResponse['items'];
      List movies = moviesMap.map((i) => Movie.fromJson(i)).toList();
      List<Movie> typedMovies = List<Movie>.from(movies.whereType<Movie>());
      return typedMovies;
    } else {
      throw Exception('Failed to getSearchedMovies $name');
    }
  }
}
