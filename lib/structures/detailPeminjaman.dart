import 'package:hive/hive.dart';
import 'package:inventara/structures/peminjaman_status.dart';

part 'detailPeminjaman.g.dart';

@HiveType(typeId: 15)
class DetailPeminjamans {
  @HiveField(0)
  late int id;
  @HiveField(1)
  late PeminjamanStatus status;
  @HiveField(2)
  late DateTime? borrowedDate;
  @HiveField(3)
  late DateTime? estimatedTime;
  @HiveField(4)
  late DateTime? returnDate;
  @HiveField(5)
  late String? objective;
  @HiveField(6)
  late String? destination;
  @HiveField(7)
  late int? passenger;
  @HiveField(8)
  late int userId;
  @HiveField(9)
  late DateTime createdAt;
  @HiveField(10)
  late String? canceledReason;

  DetailPeminjamans(
      {required this.id,
      required this.status,
      required this.borrowedDate,
      required this.estimatedTime,
      required this.returnDate,
      required this.objective,
      required this.destination,
      required this.passenger,
      required this.userId,
      required this.createdAt,
      required this.canceledReason});

  factory DetailPeminjamans.fromJson(Map<String, dynamic> json) {
    return DetailPeminjamans(
        id: json['id'],
        status: PeminjamanStatus.values.firstWhere(
            (e) => e.toString() == 'PeminjamanStatus.${json['status']}'),
        borrowedDate: json['returnDate'] != null
            ? DateTime.parse(json['borrowedDate'])
            : null,
        estimatedTime: json['estimatedTime'] != null
            ? DateTime.parse(json['estimatedTime'])
            : null,
        returnDate: json['returnDate'] != null
            ? DateTime.parse(json['returnDate'])
            : null,
        objective: json['objective'],
        destination: json['destination'],
        passenger: json['passenger'],
        userId: json['userId'],
        createdAt: DateTime.parse(json['createdAt']),
        canceledReason: json['canceledReason']);
  }
}
