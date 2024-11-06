import 'package:flutter_application_1/models/user_t.dart';
import 'package:hive_flutter/hive_flutter.dart';

final box = Hive.box('TestApp');

Future<dynamic> openBox() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserTAdapter());
  Hive.openBox('TestApp');
  await Hive.openBox('SETTINGS');
  await Hive.openBox('LIBRARY');
  await Hive.openBox('SEARCH_HISTORY');
  await Hive.openBox('SONG_HISTORY');
  await Hive.openBox('FAVOURITES');
  await Hive.openBox('DOWNLOADS');
}
