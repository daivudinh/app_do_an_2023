import 'models.dart';

class MovieDetail{
  final String? backdropPath;
  final int? id;
  final String? originalLanguage;
  final List<Genre>? genres;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;
  final int? runtime;

  MovieDetail({
    this.backdropPath,
    this.id,
    this.originalLanguage,
    this.genres,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.runtime,
  });

  factory MovieDetail.fromJson(dynamic json) {
    if (json == null) {
      return MovieDetail();
    }

    List<Genre> genreIdsList =  [];

    var genreIdsFromJson = json['genres'] as List;
    for (var genre in genreIdsFromJson) {
      genreIdsList.add(
          Genre(genre["id"], genre["name"])
      );
    }

    return MovieDetail(
        backdropPath: json["backdrop_path"],
        id: int.parse(json["id"].toString()) ,
        originalLanguage: json["original_language"],
        genres: genreIdsList,
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: double.parse(json["popularity"].toString()),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        title: json["title"],
        video: json["video"],
        voteAverage: double.parse(json["vote_average"].toString()),
        voteCount: int.parse(json["vote_count"].toString()),
        runtime: int.parse(json["runtime"].toString())
    );
  }

}