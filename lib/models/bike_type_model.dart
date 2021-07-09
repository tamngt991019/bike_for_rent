class BikeTypeModel {
  String id;
  String name;

  BikeTypeModel({
    this.id,
    this.name,
  });

  factory BikeTypeModel.fromJson(Map<String, dynamic> json) => BikeTypeModel(
        id: json['id'] as String,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
