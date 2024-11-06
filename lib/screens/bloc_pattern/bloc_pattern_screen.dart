import 'package:flutter/material.dart';
import 'package:flutter_application_1/bloc_test/home/home_bloc_screen.dart';
import 'package:flutter_application_1/bloc_test/login/login_screen.dart';
import 'package:flutter_application_1/screens/bloc_pattern/bloc/remote_bloc.dart';
import 'package:flutter_application_1/screens/bloc_pattern/bloc/remote_event.dart';
import 'package:flutter_application_1/screens/bloc_pattern/bloc/remote_state.dart';
import 'package:flutter_application_1/screens/counter/screen/counter_screen.dart';
import 'package:flutter_application_1/screens/test_bloc/screen/test_bloc_screen.dart';

class BlocPatternScreen extends StatefulWidget {
  const BlocPatternScreen({super.key});

  @override
  State<BlocPatternScreen> createState() => _BlocPatternScreenState();
}

class _BlocPatternScreenState extends State<BlocPatternScreen> {
  final bloc = RemoteBloc();

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test bl'),
        backgroundColor: Colors.pink,
      ),
      body: Center(
          child: StreamBuilder<RemoteState>(
              stream: bloc.stateController.stream,
              initialData: bloc.state,
              builder:
                  (BuildContext context, AsyncSnapshot<RemoteState> snapshot) {
                return Text('volume is ${snapshot.data?.volume}');
              })),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TestBlocScreen()));
              }),
          const SizedBox(
            width: 15,
          ),
          FloatingActionButton(
              onPressed: () =>
                  bloc.eventController.sink.add(IncrementVolume(add: 10))),
          const SizedBox(
            width: 15,
          ),
          FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CounterScreen()));
              }),
          FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreenBloc()));
              },
              child: const Icon(Icons.login)),
              FloatingActionButton(
              heroTag: null,
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeBlocScreen()));
              },
              child: const Icon(Icons.login))
        ],
      ),
    );
  }
}
