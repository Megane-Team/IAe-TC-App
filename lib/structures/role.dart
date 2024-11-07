import 'package:hive/hive.dart';

part 'role.g.dart';

@HiveType(typeId: 1)
enum Role {
  @HiveField(0)
  headAdmin,
  @HiveField(1)
  admin,
  @HiveField(2)
  user
}
