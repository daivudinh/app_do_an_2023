class Movie{
  final int? id;
  final String? backdropPath;
  final String? originalTitle;
  final double? popularity;
  final String? posterPath;
  final String? title;
  final double? voteAverage;

  Movie({
    this.id,
    this.backdropPath,
    this.originalTitle,
    this.popularity,
    this.posterPath,
    this.title,
    this.voteAverage,
  });

  factory Movie.fromJson(dynamic json){
    if(json == null){
      return Movie();
    }
    return Movie(
        id: int.parse(json['id'].toString()),
        backdropPath: json['backdrop_path'],
        originalTitle: json["original_title"],
        popularity: double.parse(json["vote_average"].toString()),
        posterPath: json['poster_path'],
        title: json['title'],
        voteAverage: double.parse(json["vote_average"].toString())
    );
  }
}