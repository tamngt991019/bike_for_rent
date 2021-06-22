class PaymentModel {
  String id;
  String bookingId;
  String totalPrice;
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
        totalPrice: json['totalPrice'] as String,
        paymentTypeId: json['paymentTypeId'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bookingId": bookingId,
        "totalPrice": totalPrice,
        "paymentTypeId": paymentTypeId,
      };
}
