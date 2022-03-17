part of 'movie_bloc.dart';

abstract class MovieState extends Equatable {
  const MovieState();

  @override
  List<Object?> get props => [];
}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movie;
  const MovieLoaded(this.movie);
}

class MovieDetailsLoaded extends MovieState {
  final Movie movie;
  const MovieDetailsLoaded(this.movie);
}

class MovieError extends MovieState {
  final String? message;
  const MovieError(this.message);
}