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
  int customerRating;
  String customerReport;
  int ownerRating;
  String ownerReport;
  String status;
  UserModel userModel;

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
    this.ownerRating,
    this.ownerReport,
    this.status,
    this.userModel,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        id: json['id'] as String,
        userName: json['userName'] as String,
        bikeId: json['bikeId'] as String,
        payPackageId: json['payPackageId'] as String,
        dateCreated: json['dateCreated'] as String,
        locationGetBike: json['locationGetBike'] as String,
        locationReturnBike: json['locationReturnBike'] as String,
        dateBegin: json['dateBegin'] as String,
        dateEnd: json['dateEnd'] as String,
        customerRating: json['customerRating'] as int,
        customerReport: json['customerReport'] as String,
        ownerRating: json['ownerRating'] as int,
        ownerReport: json['ownerReport'] as String,
        status: json['status'] as String,
        userModel: UserModel.fromJson(json['usernameNavigation']),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "bikeId": bikeId,
        "payPackageId": payPackageId,
        "dateCreated": dateCreated,
        "locationGetBike": locationGetBike,
        "locationReturnBike": locationReturnBike,
        "dateBegin": dateBegin,
        "dateEnd": dateEnd,
        "customerRating": customerRating,
        "customerReport": customerReport,
        "ownerRating": ownerRating,
        "ownerReport": ownerReport,
        "status": status,
      };
}
