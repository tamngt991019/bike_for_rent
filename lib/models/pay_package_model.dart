class PayPackageModel {
  String id;
  String name;
  String description;
  String price;
  String bikeTypeId;

  PayPackageModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.bikeTypeId,
  });

  factory PayPackageModel.fromJson(Map<String, dynamic> json) =>
      PayPackageModel(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        price: json['price'] as String,
        bikeTypeId: json['bikeTypeId'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "bikeTypeId": bikeTypeId,
      };
}
