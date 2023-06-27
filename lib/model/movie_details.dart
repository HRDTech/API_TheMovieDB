import 'package:flutter/cupertino.dart';
import 'package:sizer/sizer.dart';

import '/utils/constants.dart';
import '/widgets/custom_movies_button.dart';


class MovieDetails {
  final String title;
  final String year;
  final double rating;
  final Map<String, int> genres;

  final String overview;
  final String backgroundURL;

  MovieDetails({
    required this.title,
    required this.year,
    required this.rating,
    required this.genres,
    required this.overview,
    required this.backgroundURL,
  });

  List<CustomMoviesButton> getGenresList(BuildContext context) {
    List<CustomMoviesButton> temp = [];
    genres.forEach((genre, genreId) {
      temp.add(
        CustomMoviesButton(
          onPressed:() {},
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          color: kLightGrey,
          text: genre,
        ),
      );
    });

    return temp;
  }
}