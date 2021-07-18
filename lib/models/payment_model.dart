class PaymentModel {
  String id;
  String bookingId;
  double totalPrice;
  String paymentTypeId;

  PaymentModel({
    this.id,
    this.bookingId,
    this.totalPrice,
    this.paymentTypeId,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json['id'] as String,
        bookingId: json['bookingId'] as String,
        totalPrice: json['totalPrice'] as double,
        paymentTypeId: json['paymentTypeId'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bookingId": bookingId,
        "totalPrice": totalPrice,
        "paymentTypeId": paymentTypeId,
      };
}
