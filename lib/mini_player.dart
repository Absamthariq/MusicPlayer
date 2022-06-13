// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:neon_player/now_playing/now_player.dart';
// import 'package:neon_player/tracks_music_list/track_lists.dart';

// class MiniPlayer extends StatefulWidget {
//   const MiniPlayer({Key? key}) : super(key: key);

//   @override
//   State<MiniPlayer> createState() => _MiniPlayerState();
// }

// class _MiniPlayerState extends State<MiniPlayer>

//     with SingleTickerProviderStateMixin 
//     {
//        bool isAnimated = false;
//   // bool showPlay = false;
//   // bool showPause = false;
//   // List<Audio> song = [];
//   late AnimationController iconCntroller;
//   // AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');

//   // // List<String> a = [];
//   @override
//   void initState() {
//     super.initState();
//     iconCntroller = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 300));

//     // player.open(Playlist(audios: , startIndex: 0),
//     //     showNotification: true, autoStart: false);
//   }

 
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => NowPlayer()),
//         );
//       },
//       child: Container(
//         width: 100,
//         height: 65,
//         color: const Color(0xFF362047),
//         child: Row(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 20),
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   border: Border.all(
//                     color: const Color.fromARGB(255, 184, 178, 178),
//                   ),
//                 ),
//                 width: 55,
//                 height: 55,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Image.asset(
//                     'lib/assets/song_images/The_Weeknd_-_Starboy.png',
//                     fit: BoxFit.fill,
//                   ),
//                 ),
//               ),
//             ),
//             const Spacer(
//               flex: 4,
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'NOW PLAYING',
//                   style: GoogleFonts.inter(
//                       fontSize: 17,
//                       color: Colors.amber,
//                       fontWeight: FontWeight.w600),
//                 ),
//                 Text(
//                   'ARTIST NAME',
//                   style: GoogleFonts.inter(
//                       fontSize: 12,
//                       color: Colors.amber,
//                       fontWeight: FontWeight.w400),
//                 ),
//               ],
//             ),
//             const Spacer(
//               flex: 4,
//             ),
//             IconButton(
//               onPressed: () {
//                 animateicon();
                
//               },
//               icon: AnimatedIcon(
//                 icon: AnimatedIcons.play_pause,
//                 size: 40,
//                 progress: iconCntroller,
//               ),
//             ),
//             const Spacer(
//               flex: 1,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void animateicon() {
//     setState(() {
//       isAnimated = !isAnimated;

//       if (isAnimated) {
//         iconCntroller.forward();
//         player.play();
//       } else {
//         iconCntroller.reverse();
//         player.pause();
//       }
//     });
//   }
// }
