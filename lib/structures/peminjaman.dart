import 'package:hive/hive.dart';
import 'peminjaman_category.dart';

part 'peminjaman.g.dart';

@HiveType(typeId: 8)
class Peminjaman {
  @HiveField(0)
  late int id;
  @HiveField(1)
  late PeminjamanCategory category;
  @HiveField(2)
  late int userId;
  @HiveField(3)
  late int? ruanganId;
  @HiveField(4)
  late int? barangId;
  @HiveField(5)
  late int? kendaraanId;
  @HiveField(6)
  late int? detailPeminjamanId;
  @HiveField(7)
  late DateTime createdAt;

  Peminjaman({
    required this.id,
    required this.category,
    required this.userId,
    required this.ruanganId,
    required this.barangId,
    required this.kendaraanId,
    required this.detailPeminjamanId,
    required this.createdAt,
  });

  factory Peminjaman.fromJson(Map<String, dynamic> json) {
    return Peminjaman(
      id: json['id'],
      category: PeminjamanCategory.values.firstWhere(
          (e) => e.toString() == 'PeminjamanCategory.${json['category']}'),
      userId: json['userId'],
      ruanganId: json['ruanganId'],
      barangId: json['barangId'],
      kendaraanId: json['kendaraanId'],
      detailPeminjamanId: json['detailPeminjamanId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
