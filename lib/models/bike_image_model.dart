class BikeImageModel{
  String id;
  String imageUrl;
  String bikeId;

  BikeImageModel({
    this.id,
    this.imageUrl,
    this.bikeId,
  });

  factory BikeImageModel.fromJson(Map<String, dynamic> json) => BikeImageModel(
    id: json['id'] as String,
    imageUrl: json['imageUrl'] as String,
    bikeId: json['bikeId'] as String,
  );

  Map<String, dynamic> toJson() => {
    "id" : id,
    "imageUrl" : imageUrl,
    "bikeId" : bikeId,
  };
}