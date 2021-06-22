class BikeBrandModel{
  String id;
  String name;

  BikeBrandModel({
    this.id,
    this.name,
  });

  factory BikeBrandModel.fromJson(Map<String, dynamic> json) => BikeBrandModel(
    id: json['id'] as String,
    name: json['name'] as String,
  );

  Map<String, dynamic> toJson() => {
    "id" : id,
    "name" : name,
  };
}