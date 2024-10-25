import 'package:flutter_application_1/models/user_t.dart';
import 'package:hive_flutter/hive_flutter.dart';

final box = Hive.box('TestApp');

Future<dynamic> openBox() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserTAdapter());
  return Hive.openBox('TestApp');
}
