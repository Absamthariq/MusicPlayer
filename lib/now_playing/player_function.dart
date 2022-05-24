// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/material.dart';
// import 'package:neon_player/tracks_music_list/track_lists.dart';

// class PlayingFunction extends StatefulWidget {
//    PlayingFunction({Key? key}) : super(key: key);

//   @override
//   State<PlayingFunction> createState() => _PlayingFunctionState();
// }

// class _PlayingFunctionState extends State<PlayingFunction>
//     with SingleTickerProviderStateMixin {
//   double _currentSliderValue = 20;

//   bool isAnimated = false;
//   bool showPlay = false;
//   bool showPause = false;
//   List<Audio> song = [];
//   late AnimationController iconCntroller;
//   AssetsAudioPlayer player = AssetsAudioPlayer();

//   // List<String> a = [];
//   @override
//   void initState() {
//     super.initState();
//     iconCntroller = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 300));

//     player.open(Playlist(audios: audio, startIndex: 0),
//         showNotification: true, autoStart: false);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//    );
//   }
//     }