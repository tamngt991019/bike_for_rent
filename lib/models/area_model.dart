class AreaModel{
  String id;
  String name;
  String cityId;

  AreaModel({
  this.id,
  this.name,
  this.cityId,
});

factory AreaModel.fromJson(Map<String, dynamic> json) => AreaModel(
    id: json['id'] as String,
    name: json['name'] as String,
    cityId: json['cityId'] as String,
);

Map<String, dynamic> toJson() => {
"id" : id,
"name" : name,
"cityId" : cityId,
};
}