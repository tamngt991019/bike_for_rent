import 'package:bike_for_rent/models/bike_type_model.dart';

class PayPackageModel {
  String id;
  String name;
  String description;
  dynamic price, hours;
  String bikeTypeId;
  BikeTypeModel bikeTypeModel;

  PayPackageModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.hours,
    this.bikeTypeId,
    this.bikeTypeModel,
  });

  factory PayPackageModel.fromJson(Map<String, dynamic> json) =>
      PayPackageModel(
        id: json['id'] as String,
        name: json['name'] as String,
        description: json['description'] as String,
        price: json['price'] as dynamic,
        hours: json['hours'] as dynamic,
        bikeTypeId: json['bikeTypeId'] as String,
        bikeTypeModel: json['bikeType'] == null
            ? null
            : BikeTypeModel.fromJson(json['bikeType']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "price": price,
        "bikeTypeId": bikeTypeId,
      };
}
