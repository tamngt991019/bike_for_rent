class BookingEventModel {
  String id;
  String dateCreated;
  String bookingId;
  String description;
  String latitude;
  String longtitude;
  String dateEnd;
  String eventTypeId;
  // String locationId;

  BookingEventModel({
    this.id,
    this.dateCreated,
    this.bookingId,
    this.description,
    this.latitude,
    this.longtitude,
    this.dateEnd,
    this.eventTypeId,
    // this.locationId,
  });

  factory BookingEventModel.fromJson(Map<String, dynamic> json) =>
      BookingEventModel(
        id: json['id'] as String,
        dateCreated: json['dateCreated'] as String,
        bookingId: json['bookingId'] as String,
        description: json['description'] as String,
        dateEnd: json['dateEnd'] as String,
        eventTypeId: json['eventTypeId'] as String,
        // locationId: json['locationId'] as String,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "dateCreated": dateCreated,
        "bookingId": bookingId,
        "description": description,
        "latitude": latitude,
        "longtitude": longtitude,
        "dateEnd": dateEnd,
        "eventTypeId": eventTypeId,
        // "locationId": locationId,
      };
}
