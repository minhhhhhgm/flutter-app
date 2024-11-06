import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc_test/setting/theme/theme.dart';
import 'package:flutter_application_1/db/hive_config.dart';
import 'package:flutter_application_1/music/mixins/ytmusic.dart';
import 'package:flutter_application_1/music/service/media_player.dart';
import 'package:flutter_application_1/music/service/settings_manager.dart';
import 'package:flutter_application_1/root_bloc/root_bloc.dart';
import 'package:flutter_application_1/root_bloc/root_state.dart';
import 'package:flutter_application_1/widgets/bottom_nav_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await openBox();
  YTMusic ytMusic = YTMusic();
  await ytMusic.init();
  SettingsManager settingsManager = SettingsManager();
  GetIt.I.registerSingleton<SettingsManager>(settingsManager);
  MediaPlayer mediaPlayer = MediaPlayer();
  GetIt.I.registerSingleton<MediaPlayer>(mediaPlayer);
  GetIt.I.registerSingleton<YTMusic>(ytMusic);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeData getTheme;
  late String theme;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    theme = box.get('theme', defaultValue: 'red');
    print('theme $theme');
    getTheme = _getTheme(theme);
  }

  ThemeData _getTheme(String themeName) {
    switch (themeName) {
      case 'black':
        return appTheme['black']!;
      case 'pink':
        return appTheme['pink']!;
      case 'red':
        return appTheme['red']!;
      case 'blue':
        return appTheme['blue']!;
      case 'green':
        return appTheme['green']!;
      case 'gray':
        return appTheme['gray']!;
      case 'jade':
        return appTheme['jade']!;
      case 'royal':
        return appTheme['royal']!;

      default:
        return appTheme['black']!;
    }
  }

  void listener(BuildContext context, RootState state) {
    if (state is ChangeThemeState) {
      print('State receive ${state.themeName}');
      getTheme = _getTheme(state.themeName);
      print(Theme.of(context).primaryColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RootBloc(),
      child: BlocConsumer<RootBloc, RootState>(
          listener: listener,
          builder: (context, state) {
            return MaterialApp(
              title: 'Flutter Demo',
              home: const BottomNavBar(),
              theme: getTheme,
              debugShowCheckedModeBanner: false,
            );
          }),
    );
  }
}
