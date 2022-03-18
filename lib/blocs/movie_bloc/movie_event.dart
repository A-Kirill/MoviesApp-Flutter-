part of 'movie_bloc.dart';

abstract class MovieEvent extends Equatable {
  const MovieEvent();

  @override
  List<Object> get props => [];
}

class GetMovieList extends MovieEvent {
  final DateTime? mDate;
  const GetMovieList(this.mDate);
}

class GetSearchedMovies extends MovieEvent {
  final String query;
  const GetSearchedMovies(this.query);
}

class GetMovieDetails extends MovieEvent {
  final int id;
  const GetMovieDetails(this.id);
}

