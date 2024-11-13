import 'package:hive/hive.dart';

part 'ruangan_category.g.dart';

@HiveType(typeId: 5)
enum RuanganCategory {
  @HiveField(0)
  kelas,
  @HiveField(1)
  lab,
  @HiveField(2)
  gudang
}
