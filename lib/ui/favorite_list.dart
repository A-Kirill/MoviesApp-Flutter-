import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:movies_fltr/storage/favorite_notifier.dart';
import 'package:provider/provider.dart';

import '../models/movies_response.dart';
import '../supporting/supporting_methods.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({Key? key}) : super(key: key);

  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: buildBackgroundDecoration(context),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            title: Text(translate('app_bar.bookmarks')),
            backgroundColor: Colors.transparent,
            elevation: 0,
          actions: [
            IconButton(
                onPressed: (){
                  sortMovies();
                },
                icon: const Icon(Icons.sort_by_alpha))
          ],
        ),
        body: Consumer<FavoriteNotifier>(
        builder: (context, snapshot, _) => ListView.builder(
                      itemCount: snapshot.moviesStore.length,
                      itemBuilder: (BuildContext context, int index) {
                        List<Movie> movieList = snapshot.moviesStore;
                        Movie movie = movieList[index];
                        return Dismissible(
                            key: UniqueKey(),
                            direction: DismissDirection.endToStart,
                            onDismissed: (_) {
                              removeMovie(movie);
                            },
                            background: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 20),
                              alignment: Alignment.centerRight,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                            child: buildCard(movie, context));
                      },
                    ),
        )
      ),
    );
  }

  void removeMovie(Movie movie) {
    Provider.of<FavoriteNotifier>(context, listen: false).deleteMovie(movie);
  }

  void sortMovies() {
    Provider.of<FavoriteNotifier>(context, listen: false).sortMovies();
  }
}
