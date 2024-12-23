import 'dart:convert';

AllnewsModel allnewsModelFromJson(String str) =>
    AllnewsModel.fromJson(json.decode(str));

class AllnewsModel {
  String? status;
  List<Source>? sources;

  AllnewsModel({
    this.status,
    this.sources,
  });

  factory AllnewsModel.fromJson(Map<String, dynamic> json) => AllnewsModel(
        status: json["status"],
        sources: json["sources"] == null
            ? []
            : List<Source>.from(
                json["sources"]!.map((x) => Source.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "sources": sources == null
            ? []
            : List<dynamic>.from(sources!.map((x) => x.toJson())),
      };
}

class Source {
  String? id;
  String? name;
  String? description;
  String? url;
  String? language;
  String? country;

  Source({
    this.id,
    this.name,
    this.description,
    this.url,
    this.language,
    this.country,
  });

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        url: json["url"],
        language: json["language"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "url": url,
        "language": language,
        "country": country,
};
}
