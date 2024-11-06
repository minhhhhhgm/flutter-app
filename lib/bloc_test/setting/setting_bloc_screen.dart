import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc_test/demo/demo_first.dart';
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
    ThemeE(color: 'red', name: 'Red', listTheme: [
      ThemeE(color: 'jade', name: 'Jade'),
      ThemeE(color: 'royal', name: 'Royal')
    ]),
    ThemeE(color: 'pink', name: 'Pink', listTheme: []),
    ThemeE(color: 'gray', name: 'Gray', listTheme: []),
    ThemeE(color: 'green', name: 'Green', listTheme: []),
    ThemeE(color: 'blue', name: 'Blue', listTheme: []),
    ThemeE(color: 'black', name: 'Black', listTheme: []),
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
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const DemoFirst(),));
              },
              child: Text('theme.name', style: Theme.of(context).textTheme.bodySmall)),
            Expanded(
              child: ListView.builder(
                  // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  //   crossAxisCount: 3,
                  //   crossAxisSpacing: 10,
                  //   mainAxisSpacing: 10,
                  // ),
                  itemCount: listTheme.length,
                  itemBuilder: (BuildContext context, int index) {
                    final theme = listTheme[index];
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: context.read<RootBloc>().index == index
                                ? Colors.blueAccent
                                : Colors.pink,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: GestureDetector(
                              onTap: () {
                                print('Press');
                                context.read<RootBloc>().add(ChangeThemeEvent(
                                    themeName: theme.color,
                                    index: index,
                                    isExpand: theme.listTheme!.isNotEmpty));
                                box.put('theme', theme.color);
                              },
                              child: Text(theme.name,
                                  style: Theme.of(context).textTheme.bodySmall),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: context.read<RootBloc>().isExpand,
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: theme.listTheme?.length ?? 0,
                              itemBuilder: (BuildContext context, int i) {
                                return Container(
                                  decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                    colors: [Colors.black, Colors.transparent],
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.center,
                                  )),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Center(
                                      child: GestureDetector(
                                          onTap: () {
                                            print('object');
                                            context.read<RootBloc>().add(
                                                ChangeThemeEvent(
                                                    themeName: theme
                                                            .listTheme?[i]
                                                            .color ??
                                                        '',
                                                    index: index,
                                                    isExpand: true));
                                            box.put('theme', theme.color);
                                          },
                                          child: Text(
                                              theme.listTheme?[index].name ??
                                                  '')),
                                    ),
                                  ),
                                );
                              }),
                        )
                      ],
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
  final List<ThemeE>? listTheme;
  final bool? isExpand;
  ThemeE(
      {required this.color, required this.name, this.listTheme, this.isExpand});
}
