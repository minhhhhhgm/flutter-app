
import 'package:flutter_application_1/music/models/music_model.dart';

abstract class MusicState {}

class MusicStateInitial extends MusicState{}

class GetMusicState extends MusicState{
  final MusicResponse musicResponse;
  GetMusicState({required this.musicResponse});
}