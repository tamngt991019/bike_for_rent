import 'package:bike_for_rent/models/bike_brand_model.dart';
import 'package:bike_for_rent/models/bike_image_model.dart';
import 'package:bike_for_rent/models/bike_type_model.dart';
import 'package:bike_for_rent/models/user_model.dart';

class BikeModel {
  String id;
  String username;
  String brandId;
  String model;
  String color;
  String licensePlates;
  String typeId;
  String locationId;
  bool isBooking;
  bool isRentingEnable;
  String status;
  BikeTypeModel bikeTypeModel;
  BikeBrandModel bikeBrandModel;
  List<BikeImageModel> listBikeImage;
  UserModel userModel;

  BikeModel({
    this.id,
    this.username,
    this.brandId,
    this.model,
    this.color,
    this.licensePlates,
    this.typeId,
    this.locationId,
    this.isBooking,
    this.isRentingEnable,
    this.status,
    this.bikeTypeModel,
    this.bikeBrandModel,
    this.listBikeImage,
    this.userModel,
  });

  factory BikeModel.fromJson(Map<String, dynamic> json) => BikeModel(
        id: json['id'] as String,
        username: json['username'] as String,
        brandId: json['brandId'] as String,
        model: json['model'] as String,
        color: json['color'] as String,
        licensePlates: json['licensePlates'] as String,
        typeId: json['typeId'] as String,
        locationId: json['locationId'] as String,
        isBooking: json['isBooking'] as bool,
        isRentingEnable: json['isRentingEnable'] as bool,
        status: json['status'] as String,
        bikeTypeModel:
            json['type'] == null ? null : BikeTypeModel.fromJson(json['type']),
        bikeBrandModel: json['brand'] == null
            ? null
            : BikeBrandModel.fromJson(json['brand']),
        listBikeImage: List<BikeImageModel>.from(
            json['bikeImages'].map((x) => BikeImageModel.fromJson(x))),
        userModel: json['usernameNavigation'] == null
            ? null
            : UserModel.fromJson(json['usernameNavigation']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "brandId": brandId,
        "model": model,
        "color": color,
        "licensePlates": licensePlates,
        "typeId": typeId,
        "locationId": locationId,
        "isBooking": isBooking,
        "isRentingEnable": isRentingEnable,
        "status": status,
      };
}
