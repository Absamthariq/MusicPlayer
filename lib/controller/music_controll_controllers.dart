import 'dart:ffi';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:neon_player/tracks_music_list/track_lists.dart';

class MusicController extends GetxController {
  bool isShuffle = false;
  bool isRepeat = false;

  shuffleControll() {
    AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');
    isShuffle = !isShuffle;

    if (isShuffle) {
      player.toggleShuffle();
    } else {
      player.setLoopMode(LoopMode.playlist);
    }
    update();
  }
  repeatControll(){
    isRepeat =!isRepeat;

    if(isRepeat){
      player.setLoopMode(LoopMode.single);
    }else{
      player.setLoopMode(LoopMode.playlist);
    }
    update();
  }
}
