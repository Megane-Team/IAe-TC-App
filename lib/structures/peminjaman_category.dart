import 'package:hive/hive.dart';

part 'peminjaman_category.g.dart';

@HiveType(typeId: 9)
enum PeminjamanCategory {
  @HiveField(0)
  barang,
  @HiveField(1)
  ruangan,
  @HiveField(2)
  kendaraan
}
