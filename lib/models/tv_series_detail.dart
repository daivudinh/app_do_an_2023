import 'models.dart';

class TVSeriesDetail {
  final String? backdropPath;
  final int? id;
  final List<Genre>? genres;
  final String? firstAirDate;
  final String? lastAirDate;
  final String? name;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? status;
  final String? tagline;
  final String? type;
  final double? voteAverage;
  final int? voteCount;

  TVSeriesDetail({
    this.backdropPath,
    this.id,
    this.genres,
    this.firstAirDate,
    this.lastAirDate,
    this.name,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.status,
    this.tagline,
    this.type,
    this.voteAverage,
    this.voteCount,
  });

  factory TVSeriesDetail.fromJson(dynamic json) {
    if (json == null) {
      return TVSeriesDetail();
    }

    List<Genre> genreIdsList =  [];

    var genreIdsFromJson = json['genres'] as List;
    for (var genre in genreIdsFromJson) {
      genreIdsList.add(
          Genre(genre["id"], genre["name"])
      );
    }

    return TVSeriesDetail(
      backdropPath: json["backdrop_path"],
      id: int.parse(json["id"].toString()),
      genres: genreIdsList,
      firstAirDate: json["first_air_date"],
      lastAirDate: json["last_air_date"],
      name: json["name"],
      numberOfEpisodes: int.parse(json["number_of_episodes"].toString()),
      numberOfSeasons: int.parse(json["number_of_seasons"].toString()),
      originalLanguage: json["original_language"],
      originalName: json["original_name"],
      overview: json["overview"],
      popularity: double.parse(json["popularity"].toString()),
      posterPath: json["poster_path"],
      status: json["status"],
      tagline: json["tagline"],
      type: json["type"],
      voteAverage: double.parse(json["vote_average"].toString()),
      voteCount: int.parse(json["vote_count"].toString()),
    );
  }
}
