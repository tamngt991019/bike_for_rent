class LocationModel {
  String id;
  String name;
  String address;
  String areaId;
  String locationTypeId;
  String latitude;
  String longitude;

  LocationModel({
    this.id,
    this.name,
    this.address,
    this.areaId,
    this.locationTypeId,
    this.latitude,
    this.longitude,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        id: json['id'] as String,
        name: json['name'] as String,
        address: json['address'] as String,
        areaId: json['areaId'] as String,
        locationTypeId: json['locationTypeId'] as String,
        latitude: json['latitude'] as String,
        longitude: json['longitude'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "areaId": areaId,
        "locationTypeId": locationTypeId,
        "latitude": latitude,
        "longitude": longitude,
      };
}
