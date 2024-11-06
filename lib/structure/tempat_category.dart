import 'package:hive/hive.dart';

@HiveType(typeId: 3)
enum tempatCategory{
  @HiveField(0)
  parkiran,
  @HiveField(1)
  gedung
}