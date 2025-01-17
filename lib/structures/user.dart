import 'package:hive/hive.dart';
import 'package:inventara/structures/role.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  late int id;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late String nik;
  @HiveField(3)
  late String? email;
  @HiveField(4)
  late Role? role;
  @HiveField(5)
  late String unit;
  @HiveField(6)
  late String address;
  @HiveField(7)
  late String? photo;
  @HiveField(8)
  late String phone;
  @HiveField(9)
  late DateTime createdAt;


  User(
      {required this.id,
      required this.name,
      required this.nik,
      required this.email,
      required this.role,
      required this.unit,
      required this.address,
      required this.photo,
      required this.phone,
      required this.createdAt,});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        name: json['name'],
        nik: json['nik'],
        email: json['email'],
        role: Role.values
            .firstWhere((e) => e.toString() == 'Role.${json['role']}'),
        unit: json['unit'],
        address: json['address'],
        photo: json['photo'],
        phone: json['phoneNumber'],
        createdAt: DateTime.parse(json['createdAt']));
  }
}
