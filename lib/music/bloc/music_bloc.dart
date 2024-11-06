import 'package:flutter_application_1/music/bloc/music_event.dart';
import 'package:flutter_application_1/music/bloc/music_state.dart';
import 'package:flutter_application_1/music/mixins/yt_service_provider.dart';
import 'package:flutter_application_1/music/mixins/ytmusic.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart';
class MusicBloc extends Bloc<MusicEvent, MusicState> {
  final ytMusic = YTMusic();
  final httpsYtmDomain = 'https://music.youtube.com';
  final baseApiEndpoint = '/youtubei/v1/';
  final String ytmParams =
      '?alt=json&key=AIzaSyC9XL3ZjWddXya6X74dJoCTL-WEYFDNX30';
  final userAgent =
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:88.0) Gecko/20100101 Firefox/88.0';
  MusicBloc() : super(MusicStateInitial()) {
    on<GetMusicEvent>(onGetMusic);
  }

  void onGetMusic(GetMusicEvent event, Emitter<MusicState> emit) async{
    // final Uri uri = Uri.parse(
    //     httpsYtmDomain + baseApiEndpoint + event.endpoint + ytmParams);
    //     final response =
    //     await post(uri, headers: {}, body: jsonEncode(event.body));
    //     final data = json.decode(response.body);
    //     print(data);
    //     emit(GetMusicState(musicResponse: data));
     Map<String, dynamic> home = await ytMusic.browse();
    print('HOME === $home');

  }
}
