import 'dart:collection';
import 'package:flutter/material.dart';
import '../models/movies_response.dart';
import 'json_storage.dart';

class FavoriteNotifier with ChangeNotifier {

  List<Movie> _moviesStore = [];

  UnmodifiableListView<Movie> get moviesStore => UnmodifiableListView(_moviesStore);

  var store = JsonStorage();
  var isAlph = false;

  void initialize() {
    store.readMovies().then((value) {
      _moviesStore = value;
      notifyListeners();
    });
  }

  void refreshMovies() {
    store.readMovies().then((value) {
      _moviesStore = value;
      notifyListeners();
    });
  }

  void addMovie(Movie movie) {
    store.writeMovies(movie).then((_) {
      _moviesStore = store.moviesStore;
      notifyListeners();
    });
  }

  void deleteMovie(Movie movie) {
    store.deleteMovies(movie).then((_) {
      _moviesStore = store.moviesStore;
      notifyListeners();
    });
  }

  void sortMovies() {
    if (!isAlph) {
      _moviesStore.sort((a, b) => a.nameRu.toString().compareTo(b.nameRu.toString()));
    } else {
      _moviesStore.sort((a, b) => b.nameRu.toString().compareTo(a.nameRu.toString()));
    }
    isAlph = !isAlph;
    notifyListeners();
  }

}