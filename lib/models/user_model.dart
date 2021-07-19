class UserModel {
  String username;
  String password;
  String fullName;
  String email;
  String phone;
  String avatar;
  String dateCreated;
  bool userVerified;
  String identityNo;
  String frontIdentityImage;
  String backIdentityImage;
  bool ownerVerified;
  bool isRenting;
  String status;
  dynamic token;

  UserModel({
    this.username,
    this.password,
    this.fullName,
    this.email,
    this.phone,
    this.avatar,
    this.dateCreated,
    this.userVerified,
    this.identityNo,
    this.frontIdentityImage,
    this.backIdentityImage,
    this.ownerVerified,
    this.isRenting,
    this.status,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        username: json['username'] as String,
        password: json['password'] as String,
        fullName: json['fullName'] as String,
        email: json['email'] as String,
        phone: json['phone'] as String,
        avatar: json['avatar'] as String,
        dateCreated: json['dateCreated'] as String,
        userVerified: json['userVerified'] as bool,
        identityNo: json['identityNo'] as String,
        frontIdentityImage: json['frontIdentityImage'] as String,
        backIdentityImage: json['backIdentityImage'] as String,
        ownerVerified: json['ownerVerified'] as bool,
        isRenting: json['isRenting'] as bool,
        status: json['status'] as String,
        token: json['token'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "fullName": fullName,
        "email": email,
        "phone": phone,
        "avatar": avatar,
        "dateCreated": dateCreated,
        "userVerified": userVerified,
        "identityNo": identityNo,
        "frontIdentityImage": frontIdentityImage,
        "backIdentityImage": backIdentityImage,
        "ownerVerified": ownerVerified,
        "isRenting": isRenting,
        "status": status,
      };
}
