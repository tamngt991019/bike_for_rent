class PaymentModel {
  String id;
  String bookingId;
  dynamic totalPrice;
  String paymentTypeId;
  String dateCreated;

  PaymentModel({
    this.id,
    this.bookingId,
    this.totalPrice,
    this.paymentTypeId,
    this.dateCreated,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json['id'] as String,
        bookingId: json['bookingId'] as String,
        totalPrice: json['totalPrice'] as dynamic,
        paymentTypeId: json['paymentTypeId'] as String,
        dateCreated: json['dateCreated'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bookingId": bookingId,
        "totalPrice": totalPrice,
        "paymentTypeId": paymentTypeId,
        "dateCreated": dateCreated,
      };
}
