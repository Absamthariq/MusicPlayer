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

          timeLabelTextStyle:  TextStyle(color: Colors.grey[700],),
          baseBarColor: Colors.grey[700],
          progressBarColor: Colors.grey[700],
          // bufferedBarColor: const Color(0xFF32C437),
          thumbColor: Colors.grey[700],
          timeLabelLocation: TimeLabelLocation.sides,

          barHeight: 1.0,
        ),
      );
    });
  }
}
