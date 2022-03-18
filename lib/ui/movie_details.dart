import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movies_fltr/models/movies_response.dart';
import 'package:movies_fltr/storage/favorite_notifier.dart';
import 'package:movies_fltr/ui/separator.dart';
import 'package:movies_fltr/ui/video_list.dart';
import 'package:provider/provider.dart';
import '../storage/json_storage.dart';
import '../supporting/supporting_methods.dart';
import 'image_list.dart';
import '../blocs/movie_bloc/movie_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetails extends StatefulWidget {
  final Movie movie;

  const MovieDetails({Key? key, required this.movie}) : super(key: key);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  static const titleStyle =
      TextStyle(fontSize: 15, fontWeight: FontWeight.w500);
  final MovieBloc _moviesBloc = MovieBloc();

  bool _inFavorites = false;

  @override
  initState() {
    super.initState();
    isFavorite();
    _moviesBloc.add(GetMovieDetails(widget.movie.kinopoiskId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Container(
        decoration: buildBackgroundDecoration(context),
        child: BlocProvider(
            create: (_) => _moviesBloc,
            child: BlocListener<MovieBloc, MovieState>(
              listener: (context, state) {
                if (state is MovieError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message!),
                    ),
                  );
                }
              },
              child:
                  BlocBuilder<MovieBloc, MovieState>(builder: (context, state) {
                if (state is MovieInitial) {
                  return _buildLoading();
                } else if (state is MovieLoading) {
                  return _buildLoading();
                } else if (state is MovieDetailsLoaded) {
                  return _buildContent(widget.movie, state.movie);
                } else if (state is MovieError) {
                  return Container();
                } else {
                  return Container();
                }
              }),
            )),
      ),
    );
  }

  _buildContent(Movie commonData, [Movie? snapshot]) {
    return ListView(scrollDirection: Axis.vertical, children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: Colors.white,
                  spreadRadius: 5,
                  blurRadius: 15,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: CachedNetworkImage(
                imageUrl: widget.movie.posterUrl,
                width: 150,
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      IconButton(
                        iconSize: 30,
                        color: Colors.blueGrey,
                        icon: Icon(_inFavorites
                            ? Icons.bookmark
                            : Icons.bookmark_border),
                        onPressed: () {
                          setState(() {
                            _inFavorites == false
                                ? Provider.of<FavoriteNotifier>(context,
                                        listen: false)
                                    .addMovie(widget.movie)
                                : Provider.of<FavoriteNotifier>(context,
                                        listen: false)
                                    .deleteMovie(widget.movie);
                            _inFavorites = !_inFavorites;
                          });
                        },
                      ),
                    ],
                  ),
                  Text(
                    widget.movie.nameRu ?? widget.movie.nameOriginal ?? '',
                    style: titleStyle,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.movie.year.toString()),
                      snapshot == null ? Container() : _buildRating(snapshot)
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(widget.movie.getGenres),
                  const SizedBox(height: 10),
                  Text(widget.movie.getCountries),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Spacer(),
                      IconButton(
                        iconSize: 40,
                        color: Colors.blueGrey,
                        icon: const Icon(Icons.play_circle_fill),
                        onPressed: () {
                          MaterialPageRoute route = MaterialPageRoute(
                              builder: (_) => VideoList(
                                    movieId: widget.movie.kinopoiskId,
                                  ));
                          Navigator.push(context, route);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ]),
      ),
      const Separator(),
      snapshot == null
          ? Container()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(snapshot.description ?? 'No description'),
            ),
      const Separator(),
      SizedBox(height: 200, child: ImageList(imageId: commonData.kinopoiskId)),
    ]);
  }

  Container _buildRating(Movie snapshot) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular((5))),
        color: snapshot.ratingKinopoisk == null
            ? Colors.transparent
            : Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Text(
          snapshot.ratingKinopoisk == null
              ? ''
              : snapshot.ratingKinopoisk.toString(),
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  isFavorite() async {
    var state = await JsonStorage().isFavorite(widget.movie);
    setState(() {
      _inFavorites = state;
    });
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
