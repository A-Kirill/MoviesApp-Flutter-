import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_fltr/models/models.dart';
import 'package:movies_fltr/network/api_repository.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieBloc() : super(MovieInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetMovieList>((event, emit) async {
      try {
        emit(MovieLoading());
        final mList =
            await _apiRepository.getPremiers(month: 'APRIL', year: '2022');
        emit(MovieLoaded(mList));
      } on NetworkError {
        emit(movieError());
      }
    });

    on<GetSearchedMovies>((event, emit) async {
      try {
        emit(MovieLoading());
        final mList = await _apiRepository.getSearchedMovies(event.query);
        emit(MovieLoaded(mList));
      } on NetworkError {
        emit(movieError());
      }
    });

    on<GetMovieDetails>((event, emit) async {
      try {
        emit(MovieLoading());
        final movie = await _apiRepository.getMovieDetailsBy(event.id);
        emit(MovieDetailsLoaded(movie));
      } on NetworkError {
        emit(movieError());
      }
    });
  }

  MovieError movieError() =>
      const MovieError("Failed to fetch data. Check your network connection");
}
