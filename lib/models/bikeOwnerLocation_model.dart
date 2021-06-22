class BikeOwnerLocation{
  String id;
  String userName;
  String locationId;
  String dateActive;

  BikeOwnerLocation({
    this.id,
    this.userName,
    this.locationId,
    this.dateActive,
  });

  factory BikeOwnerLocation.fromJson(Map<String, dynamic> json) => BikeOwnerLocation(
    id: json['id'] as String,
    userName: json['userName'] as String,
    locationId: json['locationId'] as String,
    dateActive: json['dateActive'] as String,
  );

  Map<String, dynamic> toJson() => {
    "id" : id,
    "userName" : userName,
    "locationId" : locationId,
    "dateActive" : dateActive,
  };
}