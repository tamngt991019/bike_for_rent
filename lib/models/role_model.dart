class RoleModel {
  String id;
  String name;

  RoleModel({
    this.id,
    this.name,
  });

  factory RoleModel.fromJson(Map<String, dynamic> json) => RoleModel(
        id: json['id'] as String,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
