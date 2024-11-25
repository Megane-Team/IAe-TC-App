import 'package:hive/hive.dart';

part 'notifikasi_category.g.dart';

@HiveType(typeId: 13)
enum NotifikasiCategory {
  @HiveField(0)
  PB,
  @HiveField(1)
  DK,
  @HiveField(2)
  PG,
  @HiveField(3)
  PDB,
  @HiveField(4)
  PDT,
  @HiveField(5)
  JT,
  @HiveField(6)
  DO,
  @HiveField(7)
  PP,
}