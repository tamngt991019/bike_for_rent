class BikeModel{
  String id;
  String userName;
  String brandId;
  String model;
  String color;
  String licensePlates;
  String typeId;
  String status;

  BikeModel({
    this.id,
    this.userName,
    this.brandId,
    this.model,
    this.color,
    this.licensePlates,
    this.typeId,
    this.status,
  });

  factory BikeModel.fromJson(Map<String, dynamic> json) => BikeModel(
    id: json['id'] as String,
    userName: json['userName'] as String,
    brandId: json['brandId'] as String,
    model: json['model'] as String,
    color: json['color'] as String,
    licensePlates: json['licensePlates'] as String,
    typeId: json['typeId'] as String,
    status: json['status'] as String,
  );

  Map<String, dynamic> toJson() => {
    "id" : id,
    "userName" : userName,
    "brandId" : brandId,
    "model" : model,
    "color" : color,
    "licensePlates" : licensePlates,
    "typeId" : typeId,
    "status" : status,
  };
}