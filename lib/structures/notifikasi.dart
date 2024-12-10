import 'package:hive/hive.dart';
import 'package:inventara/structures/notifikasi_category.dart';

part 'notifikasi.g.dart';

@HiveType(typeId: 12)
class Notifikasis {
  @HiveField(0)
  late int id;
  @HiveField(1)
  late NotifikasiCategory category;
  @HiveField(2)
  late bool isRead;
  @HiveField(3)
  late int userId;
  @HiveField(4)
  late int detailNotifikasiId;
  @HiveField(5)
  late DateTime createdAt;

  Notifikasis({
    required this.id,
    required this.category,
    required this.isRead,
    required this.userId,
    required this.detailNotifikasiId,
    required this.createdAt,
  });

  factory Notifikasis.fromJson(Map<String, dynamic> json) {
    return Notifikasis(
      id: json['id'],
      category: NotifikasiCategory.values.firstWhere(
          (e) => e.toString() == 'NotifikasiCategory.${json['category']}'),
      isRead: json['isRead'],
      userId: json['userId'],
      detailNotifikasiId: json['detailNotifikasiId'],
      createdAt: DateTime.parse(
        json['createdAt'],
      ),
    );
  }
}
