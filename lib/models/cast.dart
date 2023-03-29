class Cast {
  final int? id;
  final int? gender;
  final String? knownForDepartment;
  final String? name;
  final String? originalName;
  final double? popularity;
  final String? profilePath;
  final String? character;

  Cast({
    this.id,
    this.gender,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.character,
  });

  factory Cast.fromJson(dynamic json){
    if (json == null) {
      return Cast();
    }
    return Cast(
        id: int.parse(json["id"].toString()),
        gender: json["gender"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["known_for_department"],
        popularity: double.parse(json["popularity"].toString()),
        profilePath: json["profile_path"],
        character: json["character"]
    );
  }
}
