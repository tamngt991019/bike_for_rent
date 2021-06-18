// import 'package:json_annotation/json_annotation.dart';
// part 'user_model.g.dart';

// @JsonSerializable()
// class UserModel {
//   String username;
//   String fullname;
//   String avatar;
//   DateTime dateCreated;
//   String status;

//   UserModel();
//   UserModel.n(
//     this.username,
//     this.fullname,
//     this.avatar,
//     this.dateCreated,
//     this.status,
//   );

// factory UserModel.fromJson(Map<String, dynamic> json) =>
//     _$UserModelFromJson(json);
// Map<String, dynamic> toJson() => _$UserModelToJson(this);
// }

// UserModel counterModelFromJson(String str) =>
//     UserModel.fromJson(json.decode(str));

// String counterModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String username;
  String fullname;
  String avatar;
  String dateCreated;
  String status;

  UserModel({
    this.username,
    this.fullname,
    this.avatar,
    this.dateCreated,
    this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json['username'] as String,
        fullname: json['fullName'] as String,
        avatar: json['avatar'] as String,
        dateCreated: json['dateCreated'] as String,
        status: json['status'] as String,
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "fullname": fullname,
        "avatar": avatar,
        "dateCreated": dateCreated, //.toIso8601String(),
        "status": status,
      };
}
