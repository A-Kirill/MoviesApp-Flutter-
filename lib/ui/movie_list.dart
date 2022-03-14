import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:movies_fltr/models/movies_response.dart';
import 'package:movies_fltr/network/api_service.dart';
import '../supporting/supporting_methods.dart';

class MoviesList extends StatefulWidget {
  const MoviesList({Key? key}) : super(key: key);

  @override
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {

  late Future<List<Movie>> futureMovies;
  late ApiService service;
  bool isSearchClicked = false;
  final TextEditingController _queryString = TextEditingController();

  @override
  void initState() {
    super.initState();
    service = ApiService();
    futureMovies = fetchMovies();
  }

  @override
  void dispose() {
    _queryString.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: buildBackgroundDecoration(context),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              buildSliverAppBar(),
            ];
          },
          body: FutureBuilder<List<Movie>>(
              future: futureMovies,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      List<Movie> movieList = snapshot.data!;
                      Movie movie = movieList[index];
                      return buildCard(movie, context);
                    },
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const Center(child: CircularProgressIndicator());
              }),
        ),
      ),
    );
  }

  SliverAppBar buildSliverAppBar() {
    return SliverAppBar(
      pinned: false,
      snap: false,
      floating: true,
      expandedHeight: 120.0,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        title: isSearchClicked
            ? Container(
                padding: const EdgeInsets.only(right: 50),
                constraints: const BoxConstraints(minHeight: 30, maxHeight: 30),
                width: 220,
                child: TextField(
                    controller: _queryString,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        contentPadding: const EdgeInsets.all(10),
                        border: const OutlineInputBorder(),
                        labelText: translate('common.search'),
                        labelStyle: const TextStyle(fontSize: 10)),

                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 10),
                    maxLines: 1,
                    onSubmitted: (String value) async {
                      searchMovies(value).then((value) {
                        setState(() {});
                      });
                    }),
              )
            : Text(translate('app_bar.title')),
        background: const FlutterLogo(),
      ),
      actions: [
        IconButton(
          onPressed: () {
            setState(() {
              isSearchClicked = !isSearchClicked;
            });
          },
          icon:
              isSearchClicked ? const Icon(Icons.close_outlined)
                  : const Icon(Icons.search),
        )
      ],
    );
  }

  Future<List<Movie>> fetchMovies() async {
    futureMovies = service.getPremiers(month: 'MARCH', year: '2022');
    return futureMovies;
  }

  Future<List<Movie>> searchMovies(String name) async {
    futureMovies = service.getSearchedMovies(name);
    return futureMovies;
  }

//from json
// Future loadMovies() async {
//   final jsonString = await rootBundle.loadString('assets/movies1.json');
//   setState(() {
//     _movieList = ApiMoviesQuery.fromJson(jsonDecode(jsonString)).items;
//   });
// }
}
