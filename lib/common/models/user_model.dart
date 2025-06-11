import 'package:work_flow/common/entities/user.dart';

class UserModel extends User {
  UserModel({
    required super.email,
    required super.birthday,
    required super.fullname,
    required super.phone,
    required super.address,
    required super.id,
    required super.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        birthday:
            json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
        fullname: json["fullname"],
        phone: json["phone"],
        address: json["address"],
        id: json["id"],
        gender: json["gender"],
      );
}
