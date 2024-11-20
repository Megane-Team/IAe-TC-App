import 'package:hive/hive.dart';
import 'kendaraan_category.dart';

part 'kendaraan.g.dart';

@HiveType(typeId: 10)
class Kendaraan {
  @HiveField(0)
  late int id;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late String plat;
  @HiveField(3)
  late String status;
  @HiveField(4)
  late String condition;
  @HiveField(5)
  late DateTime warranty;
  @HiveField(6)
  late int capacity;
  @HiveField(7)
  late KendaraanCategory? category;
  @HiveField(8)
  late String color;
  @HiveField(9)
  late String? photo;
  @HiveField(10)
  late int tempatId;

  Kendaraan(
      {required this.id,
      required this.name,
      required this.plat,
      required this.status,
      required this.condition,
      required this.warranty,
      required this.capacity,
      required this.category,
      required this.color,
      required this.photo,
      required this.tempatId});

  factory Kendaraan.fromJson(Map<String, dynamic> json) {
    return Kendaraan(
        id: json['id'],
        name: json['name'],
        plat: json['plat'],
        status: json['status'],
        condition: json['condition'],
        warranty: DateTime.parse(json['warranty']),
        capacity: json['capacity'],
        category: KendaraanCategory.values.firstWhere(
            (e) => e.toString() == 'KendaraanCategory.${json['category']}'),
        color: json['color'],
        photo: json['photo'],
        tempatId: json['tempat_id']);
  }
}
