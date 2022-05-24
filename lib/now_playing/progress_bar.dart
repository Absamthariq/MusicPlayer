import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';

class ProgressBarLine extends StatelessWidget {
  ProgressBarLine({Key? key}) : super(key: key);
  AssetsAudioPlayer player = AssetsAudioPlayer.withId("0");
  @override
  Widget build(BuildContext context) {
    return player.builderRealtimePlayingInfos(builder: (context, infos) {
      Duration currentPosition = infos.currentPosition;
      Duration total = infos.duration;
      return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: ProgressBar(
          progress: currentPosition,
          total: total,
          onSeek: (to) {
            player.seek(to);
          },

          timeLabelTextStyle: const TextStyle(color: Color(0xFFE9572F)),
          baseBarColor: const Color(0xFF65A888),
          progressBarColor: const Color(0xFF65A888),
          // bufferedBarColor: const Color(0xFF32C437),
          thumbColor: const Color(0xFF65A888),
          timeLabelLocation: TimeLabelLocation.sides,

          barHeight: 1.0,
        ),
      );
    });
  }
}
