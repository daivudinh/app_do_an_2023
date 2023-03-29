class Video {
  final String? name;
  final String? key;
  final String? site;
  final int? size;
  final String? type;
  final bool? official;
  final String? publishedAt;
  final String? id;

  Video({
    this.name,
    this.key,
    this.site,
    this.size,
    this.type,
    this.official,
    this.publishedAt,
    this.id,
  });

  factory Video.fromJson(dynamic json){
    if(json == null){
      return Video();
    }
    return Video(
        name: json["name"],
        key: json["key"],
        site: json["site"],
        size: int.parse(json["size"].toString()),
        type: json["type"],
        official: json["official"],
        publishedAt: json["published_at"],
        id: json["id"]
    );
  }
}
