class BikeOwnerLocationModel {
  String id;
  String userName;
  String locationId;
  String dateActive;

  BikeOwnerLocationModel({
    this.id,
    this.userName,
    this.locationId,
    this.dateActive,
  });

  factory BikeOwnerLocationModel.fromJson(Map<String, dynamic> json) =>
      BikeOwnerLocationModel(
        id: json['id'] as String,
        userName: json['userName'] as String,
        locationId: json['locationId'] as String,
        dateActive: json['dateActive'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userName": userName,
        "locationId": locationId,
        "dateActive": dateActive,
      };
}
