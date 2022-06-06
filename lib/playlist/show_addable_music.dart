import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neon_player/tracks_music_list/track_lists.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

class SelectSongsToPlaylist extends StatefulWidget {
  SelectSongsToPlaylist({Key? key, required this.playlistkey})
      : super(key: key);
  int playlistkey;
  @override
  State<SelectSongsToPlaylist> createState() => _SelectSongsToPlaylistState();
}

class _SelectSongsToPlaylistState extends State<SelectSongsToPlaylist> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181717),
      appBar: AppBar(
        title: Text('Add Songs'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<SongModel>>(
        future: audioQuery.querySongs(
          sortType: null,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, item) {
          if (item.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (item.data!.isEmpty) {
            return const Center(
              child: Text('No Songs Found'),
            );
          }
          List<SongModel> playlistsongs = item.data!;
          return ListView.builder(
            itemBuilder: (context, index) => ListTile(
                onTap: () async {
                  audioRoom.addTo(RoomType.PLAYLIST,
                      item.data![index].getMap.toSongEntity(),
                      playlistKey: widget.playlistkey, ignoreDuplicate: false);
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          'Song Added to Playlist',
                          style: GoogleFonts.dmSans(color: Colors.white),
                        ),
                      ),
                    );
                  setState(
                    () {},
                  );
                },
                onLongPress: () {},
                leading: CircleAvatar(
                  child: QueryArtworkWidget(
                    id: item.data![index].id,
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        'lib/assets/song_images/the-machine-dances-logo-stock-.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  item.data![index].title.toString(),
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
                subtitle: Text(
                  "${item.data![index].artist}",
                  style: const TextStyle(
                      fontSize: 13, height: 2, color: Colors.grey),
                ),
               ),
            itemCount: item.data!.length,
          );
        },
      ),
    );
  }
}
