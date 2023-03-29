class Crew {
  final int? id;
  final int? gender;
  final String? knownForDepartment;
  final String? name;
  final String? originalName;
  final double? popularity;
  final String? profilePath;
  final String? department;
  final String? job;

  Crew({
    this.id,
    this.gender,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.department,
    this.job,
  });

  factory Crew.fromJson(dynamic json){
    if(json == null){
      return Crew();
    }
    return Crew(
        id: int.parse(json["id"].toString()),
        gender: int.parse(json["gender"].toString()),
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: double.parse(json["popularity"].toString()),
        profilePath: json["profile_path"],
        department: json["department"],
        job: json["job"]
    );
  }
}
