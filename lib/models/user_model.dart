// UserModel counterModelFromJson(String str) =>
//     UserModel.fromJson(json.decode(str));

// String counterModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String username;
  String fullname;
  String avatar;
  DateTime dateCreated;
  String status;

  UserModel({
    this.username,
    this.fullname,
    this.avatar,
    this.dateCreated,
    this.status,
  });

  // factory UserModel.fromJson(Map<String, dynamic> data) => UserModel(
  //       data['username'],
  //       data['fullname'],
  //       data['avatar'],
  //       data['dateCreated'],
  //       data['status'],
  //     );
  // factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
  //       json['username'],
  //       json['fullname'],
  //       json['avatar'],
  //       json['dateCreated'],
  //       json['status'],
  //     );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json['username'] as String,
        fullname: json['fullname'] as String,
        avatar: json['avatar'] as String,
        dateCreated: json['dateCreated'] as DateTime,
        status: json['status'] as String,
      );

  // Map<String, dynamic> toJson() => {
  //       "username": username,
  //       "fullname": fullname,
  //       "avatar": avatar,
  //       "dateCreated": dateCreated.toIso8601String(),
  //       "status": status,
  //     };
}
