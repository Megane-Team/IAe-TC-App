import 'package:hive/hive.dart';

part 'barang.g.dart';

@HiveType(typeId: 7)
class Barang {
  @HiveField(0)
  late int id;
  @HiveField(2)
  late String name;
  @HiveField(3)
  late String code;
  @HiveField(4)
  late bool status;
  @HiveField(5)
  late String condition;
  @HiveField(6)
  late String warranty;
  @HiveField(7)
  late String? photo;
  @HiveField(8)
  late int ruanganId;

  Barang(
      {required this.id,
      required this.name,
      required this.code,
      required this.status,
      required this.condition,
      required this.warranty,
      required this.photo,
      required this.ruanganId});

  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
        id: json['id'],
        name: json['name'],
        code: json['code'],
        status: json['status'],
        condition: json['condition'],
        warranty: json['warranty'],
        photo: json['photo'],
        ruanganId: json['ruanganId']);
  }
}
