import 'package:flutter/material.dart';
import 'package:flutter_application_1/db/hive_config.dart';
import 'package:flutter_application_1/root_bloc/root_bloc.dart';
import 'package:flutter_application_1/root_bloc/root_event.dart';
import 'package:flutter_application_1/root_bloc/root_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingBlocScreen extends StatefulWidget {
  const SettingBlocScreen({super.key});

  @override
  State<SettingBlocScreen> createState() => _SettingBlocScreenState();
}

class _SettingBlocScreenState extends State<SettingBlocScreen> {
  final listTheme = [
    ThemeE(color: 'red', name: 'Red'),
    ThemeE(color: 'pink', name: 'Pink'),
    ThemeE(color: 'gray', name: 'Gray'),
    ThemeE(color: 'green', name: 'Green'),
    ThemeE(color: 'blue', name: 'Blue'),
    ThemeE(color: 'black', name: 'Black'),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootBloc, RootState>(builder: (context, state) {
      return Scaffold(
        //  appBar: AppBar(
        //   backgroundColor: Theme.of(context).primaryColor,
        //   title: Text('Setting Page' , style: Theme.of(context).textTheme.bodySmall,),
        // ),
        body: Column(
          children: [
            Text('theme.name',
                              style: Theme.of(context).textTheme.bodySmall),
            Expanded(
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: listTheme.length,
                  itemBuilder: (BuildContext context, int index) {
                    final theme = listTheme[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            print('Press');
                            context
                                .read<RootBloc>()
                                .add(ChangeThemeEvent(themeName: theme.color));
                            box.put('theme', theme.color);
                          },
                          child: Text(theme.name,
                              style: Theme.of(context).textTheme.bodySmall),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      );
    });
  }
}

class ThemeE {
  final String name;
  final String color;
  ThemeE({required this.color, required this.name});
}
