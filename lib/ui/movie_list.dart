import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../supporting/supporting_methods.dart';
import '../blocs/movie_bloc/movie_bloc.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class MoviesList extends StatefulWidget {
  const MoviesList({Key? key}) : super(key: key);

  @override
  _MoviesListState createState() => _MoviesListState();
}

class _MoviesListState extends State<MoviesList> {
  final MovieBloc _moviesBloc = MovieBloc();
  bool isSearchClicked = false;
  final TextEditingController _queryString = TextEditingController();
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    _moviesBloc.add(GetMovieList(selectedDate));
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
          body: BlocProvider(
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
              child: BlocBuilder<MovieBloc, MovieState>(
                builder: (context, state) {
                  if (state is MovieInitial) {
                    return _buildLoading();
                  } else if (state is MovieLoading) {
                    return _buildLoading();
                  } else if (state is MovieLoaded) {
                    return ListView.builder(
                        itemCount: state.movie.length,
                        itemBuilder: (BuildContext context, int index) {
                          return buildCard(state.movie[index], context);
                        });
                  } else if (state is MovieError) {
                    return Container();
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
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
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
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
                      _moviesBloc.add(GetSearchedMovies(value));
                    }),
              )
            : Text(translate('app_bar.title')),
        background: const FlutterLogo(),
      ),
      actions: [
        _buildSearchButton(),
        _buildMonthPicker()
      ],
    );
  }

  IconButton _buildMonthPicker() {
    return IconButton(
          onPressed: (){
            showMonthPicker(
              context: context,
              firstDate: DateTime(DateTime.now().year - 20, 1),
              lastDate: DateTime(DateTime.now().year + 5, 12),
              initialDate: selectedDate!,
            ).then((date) {
              if (date != null) {
                setState(() {
                  selectedDate = date;
                  _moviesBloc.add(GetMovieList(selectedDate));
                });
              }
            });
          },
          icon: const Icon(Icons.calendar_today));
  }

  IconButton _buildSearchButton() {
    return IconButton(
        onPressed: () {
          setState(() {
            isSearchClicked = !isSearchClicked;
          });
        },
        icon: isSearchClicked
            ? const Icon(Icons.close_outlined)
            : const Icon(Icons.search),
      );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
