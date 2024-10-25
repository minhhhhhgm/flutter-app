import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/counter/bloc/counter_bloc.dart';
import 'package:flutter_application_1/screens/counter/bloc/counter_event.dart';
import 'package:flutter_application_1/screens/counter/bloc/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => CounterBloc(), child: const Body());
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late int value;

  @override
  void initState() {
    // TODO: implement initState
    value = 0;
    super.initState();
  }

  void showLoading(){
    // context.
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    EdgeInsets padding = data.padding;
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        title: const Text('App bar'),
        leading: Builder(
          builder: (BuildContext context) {
            return GestureDetector(
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
                child: Icon(Icons.draw));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CounterBloc>().add(IncrementCounter());
        },
        child: const Icon(Icons.plus_one),
      ),
      body: BlocBuilder<CounterBloc, CounterState>(
        builder: (BuildContext context, CounterState state) {
          return SafeArea(
            child: Text(
              'Counter: ${state.counterValue} ss',
              style: TextStyle(fontSize: 24),
            ),
          );
        },
      ),

      // body: BlocListener<CounterBloc , CounterState>(
      //   listener: (context, state) {
      //     setState(() {
      //     value = state.counterValue;
      //     });
      //     if (state.counterValue == 10) {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(content: Text('Counter reached 10!')),
      //       );
      //     }
      //   },
      //   child: Center(
      //       child: Text(
      //         'Counter: $value',
      //         style: TextStyle(fontSize: 24),
      //       ),
      //     )
      // ),
      // body: BlocSelector<CounterBloc, CounterState, int>(
      //   selector: (CounterState state) {
      //     return state.counterValue;
      //   },
      //   builder: (BuildContext context, int state) {
      //     return Text(state.toString());
      //   },
      // )
    );
  }
}


class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});


  @override
  Widget build(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    EdgeInsets padding = data.padding;
    print(padding..top..bottom..left..right);
    return  Container(
        width: MediaQuery.of(context).size.width *3/6,
        color: Colors.red,
        child: Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('data')
            ],
          ),
        ),
    );
  }
}
