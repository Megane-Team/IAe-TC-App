import 'package:hive/hive.dart';

part 'tempat_category.g.dart';

@HiveType(typeId: 4)
enum TempatCategory {
  @HiveField(0)
  parkiran,
  @HiveField(1)
  gedung
}
