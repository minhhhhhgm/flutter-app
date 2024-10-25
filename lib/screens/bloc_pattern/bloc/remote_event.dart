abstract class RemoteEvent {}

class IncrementVolume extends RemoteEvent {
  final int add;

  IncrementVolume({required this.add});
}

class DecrementVolume extends RemoteEvent {
  final int minus;

  DecrementVolume({required this.minus});
}

class MuteVolume extends RemoteEvent {
  MuteVolume();
}
