


class Movie{
  final String id;
  final String title;
  final String? imageUrl;
  final String year;
  final double rating;
  String overview;

  Movie({
    required this.id,
    required this.title,
    this.imageUrl,
    required this.year,
    required this.rating,
    required this.overview});
}