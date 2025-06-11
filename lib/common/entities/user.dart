class User {
  final int? id;
  final String? fullname;
  final String? email;
  final String? phone;
  final String? address;
  final int? gender;
  final DateTime? birthday;

  User({
    required this.email,
    required this.birthday,
    required this.fullname,
    required this.address,
    required this.phone,
    required this.id,
    required this.gender,
  });

  User copyWith({
    int? id,
    String? fullname,
    String? email,
    String? phone,
    String? address,
    int? gender,
    DateTime? birthday,
  }) =>
      User(
        id: id ?? this.id,
        fullname: fullname ?? this.fullname,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        gender: gender ?? this.gender,
        birthday: birthday ?? this.birthday,
      );
}
