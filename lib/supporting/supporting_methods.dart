import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../models/models.dart';
import '../ui/movie_details.dart';

BoxDecoration buildBackgroundDecoration(context) {
  var brightness = Theme.of(context).brightness;
  bool isDarkMode = brightness == Brightness.dark;
  var firstColor =
      isDarkMode ? const Color(0xff080D2B) : const Color(0x4d0432ff);
  var secondColor =
      isDarkMode ? const Color(0xff2F3567) : const Color(0x3300F900);

  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        firstColor,
        secondColor,
      ],
    ),
  );
}

Widget buildCard(Movie movie, dynamic context) {
  const double _minLength = 10.0;
  const titleStyle =
      TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black);
  initializeDateFormatting('ru');

  return GestureDetector(
    onTap: () {
      MaterialPageRoute route =
          MaterialPageRoute(builder: (_) => MovieDetails(movie: movie));
      Navigator.push(context, route);
    },
    child: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      color: Colors.white70,
      child: Padding(
        padding: const EdgeInsets.all(_minLength),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                imageUrl: movie.posterUrlPreview,
                width: 60,
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(_minLength),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Text(
                        movie.nameRu ?? movie.nameOriginal ?? '',
                        style: titleStyle,
                      )),
                      const SizedBox(width: _minLength),
                      Text(
                        movie.year.toString(),
                        style: titleStyle,
                      )
                    ],
                  ),
                  const SizedBox(height: _minLength),
                  Text(movie.getGenres, style: const TextStyle(color: Colors.black)),
                  const SizedBox(height: _minLength),
                  Text(
                    movie.premiereRu != null
                        ? "В кино с ${DateFormat.yMMMd('ru').format(movie.premiereRu!)}"
                        : "",
                    style: const TextStyle(color: Colors.black),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    ),
  );
}
