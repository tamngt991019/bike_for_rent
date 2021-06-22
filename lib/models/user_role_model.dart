class UserRoleModel {
  String username;
  String roleId;
  String status;

  UserRoleModel({
    this.username,
    this.roleId,
    this.status,
  });

  factory UserRoleModel.fromJson(Map<String, dynamic> json) => UserRoleModel(
        username: json['username'] as String,
        roleId: json['roleId'] as String,
        status: json['status'] as String,
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "roleId": roleId,
        "status": status,
      };
}
