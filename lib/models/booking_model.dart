import 'package:bike_for_rent/models/bike_model.dart';
import 'package:bike_for_rent/models/event_type_model.dart';
import 'package:bike_for_rent/models/location_model.dart';
import 'package:bike_for_rent/models/pay_package_model.dart';
import 'package:bike_for_rent/models/user_model.dart';

class BookingModel {
  String id;
  String userName;
  String bikeId;
  String payPackageId;
  String dateCreated;
  String locationGetBike;
  String locationReturnBike;
  String dateBegin;
  String dateEnd;
  dynamic customerRating;
  String customerReport;
  bool isCustomerRated;
  dynamic ownerRating;
  String ownerReport;
  bool isOwnerRated;
  String eventTypeId;
  UserModel userModel;
  BikeModel bikeModel;
  LocationModel locationGetBikeModel;
  LocationModel locationReturnBikeModel;
  EventTypeModel eventTypeModel;
  PayPackageModel payPackageModel;

  BookingModel({
    this.id,
    this.userName,
    this.bikeId,
    this.payPackageId,
    this.dateCreated,
    this.locationGetBike,
    this.locationReturnBike,
    this.dateBegin,
    this.dateEnd,
    this.customerRating,
    this.customerReport,
    this.isCustomerRated,
    this.ownerRating,
    this.ownerReport,
    this.isOwnerRated,
    this.eventTypeId,
    this.userModel,
    this.bikeModel,
    this.locationGetBikeModel,
    this.locationReturnBikeModel,
    this.eventTypeModel,
    this.payPackageModel,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        id: json['id'] as String,
        userName: json['username'] as String,
        bikeId: json['bikeId'] as String,
        payPackageId: json['payPackageId'] as String,
        dateCreated: json['dateCreated'] as String,
        locationGetBike: json['locationGetBike'] as String,
        locationReturnBike: json['locationReturnBike'] as String,
        dateBegin: json['dateBegin'] as String,
        dateEnd: json['dateEnd'] as String,
        customerRating: json['customerRating'] as dynamic,
        customerReport: json['customerReport'] as String,
        isCustomerRated: json['isCustomerRated'] as bool,
        ownerRating: json['ownerRating'] as dynamic,
        ownerReport: json['ownerReport'] as String,
        isOwnerRated: json['isOwnerRated'] as bool,
        eventTypeId: json['eventTypeId'] as String,
        userModel: json['usernameNavigation'] == null
            ? null
            : UserModel.fromJson(json['usernameNavigation']),
        bikeModel:
            json['bike'] == null ? null : BikeModel.fromJson(json['bike']),
        locationGetBikeModel: json['locationGetBikeNavigation'] == null
            ? null
            : LocationModel.fromJson(json['locationGetBikeNavigation']),
        locationReturnBikeModel: json['locationReturnBikeNavigation'] == null
            ? null
            : LocationModel.fromJson(json['locationReturnBikeNavigation']),
        eventTypeModel: json['eventType'] == null
            ? null
            : EventTypeModel.fromJson(json['eventType']),
        payPackageModel: json['payPackage'] == null
            ? null
            : PayPackageModel.fromJson(json['payPackage']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": userName,
        "bikeId": bikeId,
        "payPackageId": payPackageId,
        "dateCreated": dateCreated,
        "locationGetBike": locationGetBike,
        "locationReturnBike": locationReturnBike,
        "dateBegin": dateBegin,
        "dateEnd": dateEnd,
        "customerRating": customerRating,
        "customerReport": customerReport,
        "isCustomerRated": isCustomerRated,
        "ownerRating": ownerRating,
        "ownerReport": ownerReport,
        "isOwnerRated": isOwnerRated,
        "eventTypeId": eventTypeId,
      };
}
