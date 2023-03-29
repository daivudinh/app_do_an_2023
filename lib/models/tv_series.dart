class TVSeries{
  final int? id;
  final String? backdropPath;
  final String? name;
  final String? originalName;
  final double? popularity;
  final String? posterPath;
  final double? voteAverage;

  TVSeries({
    this.id,
    this.backdropPath,
    this.name,
    this.originalName,
    this.popularity,
    this.posterPath,
    this.voteAverage,
  });

  factory TVSeries.fromJson(dynamic json){
    if(json == null){
      return TVSeries();
    }
    return TVSeries(
      id: int.parse(json["id"].toString()),
      backdropPath: json["backdrop_path"],
      name: json["name"],
      originalName: json["original_name"],
      popularity: double.parse(json["popularity"].toString()),
      posterPath: json["poster_path"],
      voteAverage: double.parse(json["vote_average"].toString()),
    );
  }

}