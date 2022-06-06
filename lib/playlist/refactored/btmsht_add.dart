// import 'package:flutter/material.dart';
// import 'package:neon_player/db/songs_models.dart';
// import 'package:neon_player/playlist/refactored/create_playlist.dart';
// import 'package:neon_player/playlist/refactored/playlist_adder.dart';
// import 'package:neon_player/tracks_music_list/track_lists.dart';

// class ShowBottomSheet extends StatelessWidget {
//     final String songId;

//   ShowBottomSheet({Key? key,required this.songId}) : super(key: key);
//   List playlist = [];

//   @override
//   Widget build(BuildContext context) {
//     final playlistName = databaseSongs(dbSongs, songId);
//     return Container(
//       decoration: const BoxDecoration(
//         color: Color(0xFF181717),
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(25.0),
//           topRight: Radius.circular(25),
//           bottomLeft: Radius.zero,
//           bottomRight: Radius.zero,
//         ),
//       ),
//       height: 300,
//       width: double.infinity,
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//         child: Stack(
//           children: [
//             ListView(shrinkWrap: true, children: [
//               AddToPlaylist(
//                 song: playlistName,
//                 countSong: "song",
//               )
//             ]),

//             //  floatting
//             Container(
//               alignment: Alignment.bottomRight,
//               child: FloatingActionButton(
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return CreatePlaylist();
//                     },
//                   );
//                 },
//                 backgroundColor: Color(0xFF181717),
//                 child: Icon(Icons.add),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//   Songs databaseSongs(List<Songs> songs, String id) {
//     return songs.firstWhere(
//       (element) => element.songurl.toString().contains(id),
//     );
//   }
// }
