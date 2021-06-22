class LocationTypeModel {
  String id;
  String name;

  LocationTypeModel({
    this.id,
    this.name,
  });

  factory LocationTypeModel.fromJson(Map<String, dynamic> json) =>
      LocationTypeModel(
        id: json['id'] as String,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
