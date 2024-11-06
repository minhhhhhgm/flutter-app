import 'package:flutter/material.dart';
import 'package:flutter_application_1/music/bloc/music_bloc.dart';
import 'package:flutter_application_1/music/bloc/music_event.dart';
import 'package:flutter_application_1/music/bloc/music_state.dart';
import 'package:flutter_application_1/music/widget/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MusicScreen extends StatelessWidget {
  @override
  // Widget build(BuildContext context) {
  //   return BlocProvider(create: (context) => MusicBloc(),
  //   child: const Body(),
  //   );
  // }

  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}


class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicBloc , MusicState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Music"),
          ),
          body:  SingleChildScrollView(
            child: Column(
              children: [
                InkWell(
                  onTap:() {
                    context.read<MusicBloc>().add(GetMusicEvent(endpoint: 'browse', body: {"browseId":"FEmusic_home","context":{"client":{"hl":"en-IN","gl":"IN","clientName":"WEB_REMIX","clientVersion":"1.20241105.01.00"},"user":{}}}));
                  },
                  child: const Text('Tss'))
              ],
            ),
          ),
        );
      },
      
      );
  }
}