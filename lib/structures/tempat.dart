import 'package:hive/hive.dart';
import 'package:inventara/structures/tempat_category.dart';

part 'tempat.g.dart';

@HiveType(typeId: 3)
class Tempat {
  @HiveField(0)
  late String id;
  @HiveField(1)
  late String name;
  @HiveField(2)
  late TempatCategory category;
  @HiveField(3)
  late String photo;
  @HiveField(4)
  late DateTime createdAt;

  Tempat(
      {required this.id,
      required this.name,
      required this.category,
      required this.photo,
      required this.createdAt});

  factory Tempat.fromJson(Map<String, dynamic> json) {
    return Tempat(
        id: json['id'],
        name: json['name'],
        category: TempatCategory.values.firstWhere(
            (e) => e.toString() == 'tempatCategory.${json['category']}'),
        photo: json['photo'],
        createdAt: DateTime.parse(json['createdAt']));
  }
}
