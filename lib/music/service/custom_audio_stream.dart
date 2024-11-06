import 'dart:async';
import 'dart:io';

import 'package:flutter_application_1/utils/pprint.dart';
import 'package:just_audio/just_audio.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'stream_client.dart';

YoutubeExplode ytExplode = YoutubeExplode();

class CustomAudioStream extends StreamAudioSource {
  String videoId;
  String quality;

  CustomAudioStream(this.videoId, this.quality, {super.tag});

  @override
  Future<StreamAudioResponse> request([int? start, int? end]) async {
    pprint('quality $quality');
    StreamManifest manifest =
        await ytExplode.videos.streamsClient.getManifest(videoId);

    List<AudioOnlyStreamInfo> streamInfos = manifest.audioOnly
        .sortByBitrate()
        .reversed
        .where((stream) => stream.container == StreamContainer.mp4)
        .toList();
    int qualityIndex = streamInfos.length - 1;
    if (quality == 'low') {
      qualityIndex = 0;
    } else {
      qualityIndex = streamInfos.length - 1;
    }
    AudioOnlyStreamInfo streamInfo = streamInfos[qualityIndex];
    start ??= 0;
    if (Platform.isAndroid) {
      end ??= (streamInfo.isThrottled
          ? (start + 10379935)
          : streamInfo.size.totalBytes);
      if (end > streamInfo.size.totalBytes) {
        end = streamInfo.size.totalBytes;
      }
    } else {
      end = streamInfo.size.totalBytes;
    }

    pprint(
        'streamInfo ${streamInfo.size.totalBytes} length : ${streamInfo.size.totalBytes}');
    pprint('Audio URL: ${streamInfo.url}');
    pprint('isThrottled : ${streamInfo.isThrottled}');

    pprint('Starting range: $start, Ending range: $end');
    pprint('streamInfo $streamInfo');

    pprint('streamInfo: ${streamInfo.codec.type}');

    return StreamAudioResponse(
      sourceLength: streamInfo.size.totalBytes,
      contentLength: end - start,
      offset: start,
      stream: AudioStreamClient()
          .getAudioStream(streamInfo, start: start, end: end),
      contentType: streamInfo.codec.type,
    );
  }
}
