
import 'package:hive_flutter/hive_flutter.dart';

part 'user_t.g.dart';

@HiveType(typeId: 0)
class UserT {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final int age;

  UserT(this.name, this.age);
}