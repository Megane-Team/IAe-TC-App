import 'package:hive/hive.dart';
import 'package:inventara/structures/peminjaman_status.dart';

part 'detailPeminjaman.g.dart';

@HiveType(typeId: 15)
class DetailPeminjaman {
  @HiveField(0)
  late int id;
  @HiveField(1)
  late PeminjamanStatus status;
  @HiveField(2)
  late DateTime? borrowedDate;
  @HiveField(3)
  late DateTime? estimatedTime;
  @HiveField(4)
  late DateTime? returnedDate;
  @HiveField(5)
  late String objective;
  @HiveField(6)
  late String? destination;
  @HiveField(7)
  late int? passenger;

  DetailPeminjaman({
    required this.id,
    required this.status,
    required this.borrowedDate,
    required this.estimatedTime,
    required this.returnedDate,
    required this.objective,
    required this.destination,
    required this.passenger,
  });

  factory DetailPeminjaman.fromJson(Map<String, dynamic> json) {
    return DetailPeminjaman(
      id: json['id'],
      status: PeminjamanStatus.values.firstWhere(
          (e) => e.toString() == 'PeminjamanStatus.${json['status']}'),
      borrowedDate: DateTime.parse(json['borrowedDate']),
      estimatedTime: DateTime.parse(json['estimatedTime']),
      returnedDate: DateTime.parse(json['returnedDate']),
      objective: json['objective'],
      destination: json['destination'],
      passenger: json['passenger'],
    );
  }
}