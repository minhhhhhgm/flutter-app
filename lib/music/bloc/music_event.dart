
abstract class MusicEvent {}

class GetMusicEvent extends MusicEvent{
    final String endpoint;
    final Map<String, dynamic> body;
    GetMusicEvent({required this.endpoint , required this.body});
}