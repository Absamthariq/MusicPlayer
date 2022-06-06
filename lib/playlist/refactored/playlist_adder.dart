// import 'package:flutter/material.dart';
// import 'package:neon_player/db/songs_models.dart';
// import 'package:neon_player/tracks_music_list/track_lists.dart';

// class AddToPlaylist extends StatelessWidget {
//   Songs song;
//   List playlists = [];
//   List<dynamic>? playlistSongs = [];
//   final countSong;
//   AddToPlaylist({Key? key, required this.countSong, required this.song})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     playlists = box.keys.toList();
//     return Column(
//       children: [
//         ...playlists
//             .map(
//               (playlistName) => playlistName != "music" &&
//                       playlistName != "favourites" &&
//                       playlistName != "recentPlayed"
//                   ? Container(
//                       decoration: BoxDecoration(
//                           color: const Color(0xFF181717),
//                           borderRadius: BorderRadius.circular(15)),
//                       child: ListTile(
//                         onTap: () async {
//                           playlistSongs = box.get(playlistName);
//                           List existingSongs = [];
//                           existingSongs = playlistSongs!
//                               .where((element) =>
//                                   element.id.toString() == song.id.toString())
//                               .toList();
//                           if (existingSongs.isEmpty) {
//                             final temp = dbSongs.firstWhere((element) =>
//                                 element.id.toString() == song.id.toString());
//                             playlistSongs?.add(temp);
//                             await box.put(playlistName, playlistSongs!);

//                             Navigator.pop(context);
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 backgroundColor: const Color(0xFF181717),
//                                 content: Text(
//                                   song.songname! + 'Added to Playlist',
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               ),
//                             );
//                           } else {
//                             Navigator.of(context).pop();
//                             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                                 content: Text(
//                               song.songname! + 'is Already in Playlist.',
//                               style: TextStyle(color: Colors.white),
//                             )));
//                           }
//                         },
//                         leading: const Padding(
//                           padding: EdgeInsets.only(left: 6.0, top: 5),
//                           child: Icon(
//                             Icons.queue_music_rounded,
//                             color: Colors.white,
//                             size: 30,
//                           ),
//                         ),

//                         // playlist name
//                         title: Padding(
//                           padding:
//                               EdgeInsets.only(left: 3.0, bottom: 3, top: 5),
//                           child: Text(
//                             playlistName.toString(),
//                             style: TextStyle(color: Colors.white, fontSize: 18),
//                           ),
//                         ),
//                         subtitle: Padding(
//                           padding: EdgeInsets.only(left: 3.0),
//                           child: Text(
//                             countSong,
//                             style: TextStyle(
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ),
//                       ),
//                     )
//                   : Container(),
//             ).toList()
//       ],
//     );
// }
// }