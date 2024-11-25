import 'package:hive/hive.dart';
import 'package:inventara/structures/notifikasi_category.dart';

part 'notifikasi.g.dart';

@HiveType(typeId: 12)
class Notifikasi {
  @HiveField(0)
  late int id;
  @HiveField(1)
  late NotifikasiCategory category;
  @HiveField(2)
  late bool isRead;
  @HiveField(3)
  late int userId;
  @HiveField(4)
  late DateTime createdAt;

  Notifikasi({
    required this.id,
    required this.category,
    required this.isRead,
    required this.userId,
    required this.createdAt,
  });

  factory Notifikasi.fromJson(Map<String, dynamic> json) {
    return Notifikasi(
      id: json['id'],
      category: NotifikasiCategory.values.firstWhere(
          (e) => e.toString() == 'NotifikasiCategory.${json['category']}'),
      isRead: json['isRead'],
      userId: json['userId'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}