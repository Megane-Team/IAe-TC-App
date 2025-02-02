import 'package:hive/hive.dart';
import 'package:inventara/structures/ruangan_category.dart';

part 'ruangan.g.dart';

@HiveType(typeId: 6)
class Ruangans {
  @HiveField(0)
  late int id;
  @HiveField(1)
  late String code;
  @HiveField(2)
  late bool status;
  @HiveField(3)
  late int? capacity;
  @HiveField(4)
  late RuanganCategory? category;
  @HiveField(5)
  late String? photo;
  @HiveField(6)
  late int tempatId;

  Ruangans({
    required this.id,
    required this.code,
    required this.status,
    required this.capacity,
    required this.category,
    required this.photo,
    required this.tempatId,
  });

  factory Ruangans.fromJson(Map<String, dynamic> json) {
    return Ruangans(
      id: json['id'],
      code: json['code'],
      status: json['status'],
      capacity: json['capacity'],
      category: RuanganCategory.values.firstWhere(
          (e) => e.toString() == 'RuanganCategory.${json['category']}'),
      photo: json['photo'],
      tempatId: json['tempatId'],
    );
  }
}
