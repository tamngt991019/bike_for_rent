class EventTypeModel {
  String id;
  String name;

  EventTypeModel({
    this.id,
    this.name,
  });

  factory EventTypeModel.fromJson(Map<String, dynamic> json) => EventTypeModel(
        id: json['id'] as String,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
