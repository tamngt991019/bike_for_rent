class PaymentTypeModel {
  String id;
  String name;

  PaymentTypeModel({
    this.id,
    this.name,
  });

  factory PaymentTypeModel.fromJson(Map<String, dynamic> json) =>
      PaymentTypeModel(
        id: json['id'] as String,
        name: json['name'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
