import 'package:intl/intl.dart';
import 'package:movies_fltr/models/models.dart';

import 'api_service.dart';

class ApiRepository {
  final _service = ApiService();

  Future<List<Movie>> getPremiers(DateTime? date) {
    var formatter = DateFormat('MMMM');
    String month = formatter.format(date!);
    String year = date.year.toString();

    return _service.getPremiers(month: month, year: year);
  }

  Future<Movie> getMovieDetailsBy(int id) {
    return _service.getMovieDetailsBy(id);
  }

  Future<List<Images>> getImagesFor(int id) {
    return _service.getImagesFor(id);
  }

  Future<List<Video>> getVideoFor(int id) {
    return _service.getVideoFor(id);
  }

  Future<List<Movie>> getSearchedMovies(String name) {
    return _service.getSearchedMovies(name);
  }
}

class NetworkError extends Error {}