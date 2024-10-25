import 'dart:async';

import 'package:flutter_application_1/screens/bloc_pattern/bloc/remote_event.dart';
import 'package:flutter_application_1/screens/bloc_pattern/bloc/remote_state.dart';

class RemoteBloc {
  var state = RemoteState(volume: 10);

  final eventController = StreamController<RemoteEvent>();

  final stateController = StreamController<RemoteState>();

  RemoteBloc() {
    eventController.stream.listen((event) {
      if (event is IncrementVolume) {
        state = RemoteState(volume: state.volume + event.add);
        print('state ${state.volume}');
      }
      if (event is DecrementVolume) {
        state = RemoteState(volume: state.volume - event.minus);
      }
      if (event is MuteVolume) {
        state = RemoteState(volume: 0);
      }

      stateController.sink.add(state);
    });
  }

  void dispose() {
    eventController.close();
    stateController.close();
  }
}
