import 'package:hive/hive.dart';

part 'peminjaman_status.g.dart';

@HiveType(typeId: 14)
enum PeminjamanStatus {
  @HiveField(0)
  draft,
  @HiveField(1)
  pending,
  @HiveField(2)
  approved,
  @HiveField(3)
  rejected,
  @HiveField(4)
  returned,
  @HiveField(5)
  canceled,
}
