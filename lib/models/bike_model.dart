class BikeModel {
  String id;
  String userName;
  String brandId;
  String model;
  String color;
  String licensePlates;
  String typeId;
  String locationId;
  bool isBooking;
  bool isRentingEnable;
  String status;

  BikeModel({
    this.id,
    this.userName,
    this.brandId,
    this.model,
    this.color,
    this.licensePlates,
    this.typeId,
    this.locationId,
    this.isBooking,
    this.isRentingEnable,
    this.status,
  });

  factory BikeModel.fromJson(Map<String, dynamic> json) => BikeModel(
        id: json['id'] as String,
        userName: json['username'] as String,
        brandId: json['brandId'] as String,
        model: json['model'] as String,
        color: json['color'] as String,
        licensePlates: json['licensePlates'] as String,
        typeId: json['typeId'] as String,
        locationId: json['locationId'] as String,
        isBooking: json['isBooking'] as bool,
        isRentingEnable: json['isRentingEnable'] as bool,
        status: json['status'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": userName,
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
