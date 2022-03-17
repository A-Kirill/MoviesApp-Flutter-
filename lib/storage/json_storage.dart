import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../models/models.dart';


class JsonStorage {

  List<Movie> moviesStore = [];

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/movies.json');
  }

  Future<List<Movie>> readMovies() async {
    try {
      final file = await _localFile;

      final contents = await file.readAsString();
      final data = await json.decode(contents);
      List movies = data.map((i) => Movie.fromJson(i)).toList();
      List<Movie> typedMovies = List<Movie>.from(movies.whereType<Movie>());
      moviesStore = typedMovies;
      return typedMovies;
    } catch (e) {
      print('Something went wrong, with $e');
      return [];
    }
  }

  Future<List<Movie>> writeMovies(Movie movie) async {
    final file = await _localFile;
    return readMovies().then((value) {
      if (!value.map((item) => item.kinopoiskId).contains(movie.kinopoiskId)) {
        moviesStore.add(movie);
        var data = jsonEncode(moviesStore);
        file.writeAsString(data);
        return moviesStore;
      }
      return [];
    });
  }

  Future<List<Movie>> deleteMovies(Movie movie) async {
    final file = await _localFile;
    return readMovies().then((value) {
      if (value.map((item) => item.kinopoiskId).contains(movie.kinopoiskId)) {
        moviesStore.removeWhere((item) => item.kinopoiskId == movie.kinopoiskId);
        var data = jsonEncode(moviesStore);
        file.writeAsString(data);
        return moviesStore;
      }
      return [];
    });
  }

  Future<bool> isFavorite(Movie movie) async {
    return readMovies().then((value) {
      return value.map((item) => item.kinopoiskId).contains(movie.kinopoiskId);
    });
  }

  Future clearDB() async {
      final file = await _localFile;
      await file.delete();
  }

}