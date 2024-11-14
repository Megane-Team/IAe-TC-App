import 'package:hive/hive.dart';

part 'kendaraan_category.g.dart';

@HiveType(typeId: 11)
enum KendaraanCategory{
  @HiveField(0)
  mobil,
  @HiveField(1)
  motor,
  @HiveField(2)
  truk
}