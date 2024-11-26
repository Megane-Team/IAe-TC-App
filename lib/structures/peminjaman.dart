import 'package:hive/hive.dart';
import 'peminjaman_category.dart';

part 'peminjaman.g.dart';

@HiveType(typeId: 8)
class Peminjaman {
  @HiveField(0)
  late int id;
  @HiveField(1)
  late String status;
  @HiveField(2)
  late PeminjamanCategory category;
  @HiveField(3)
  late DateTime borrowedDate;
  @HiveField(4)
  late DateTime estimatedTime;
  @HiveField(5)
  late DateTime? returnDate;
  @HiveField(6)
  late String destination;
  @HiveField(7)
  late String objective;
  @HiveField(8)
  late int? pasengger;
  @HiveField(9)
  late int userId;
  @HiveField(10)
  late int? ruanganId;
  @HiveField(11)
  late int? barangId;
  @HiveField(12)
  late int? kendaraanId;

  Peminjaman({
    required this.id,
    required this.status,
    required this.category,
    required this.borrowedDate,
    required this.estimatedTime,
    required this.returnDate,
    required this.destination,
    required this.objective,
    required this.pasengger,
    required this.userId,
    required this.ruanganId,
    required this.barangId,
    required this.kendaraanId,
  });

  factory Peminjaman.fromJson(Map<String, dynamic> json) {
    return Peminjaman(
      id: json['id'],
      status: json['status'],
      category: PeminjamanCategory.values.firstWhere(
          (e) => e.toString() == 'PeminjamanCategory.${json['category']}'),
      borrowedDate: DateTime.parse(json['borrowedDate']),
      estimatedTime: DateTime.parse(json['estimatedTime']),
      returnDate: json['returnDate'] != null
          ? DateTime.parse(json['returnDate'])
          : null,
      destination: json['destination'],
      objective: json['objective'],
      pasengger: json['pasengger'],
      userId: json['userId'],
      ruanganId: json['ruanganId'],
      barangId: json['barangId'],
      kendaraanId: json['kendaraanId'],
    );
  }
}
