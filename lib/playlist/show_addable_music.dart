import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neon_player/controller/addSongsController.dart';
import 'package:neon_player/tracks_music_list/track_lists.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

class SelectSongsToPlaylist extends StatelessWidget {
  SelectSongsToPlaylist({
    Key? key,
    required this.playlistkey,
  }) : super(key: key);
  int playlistkey;

  @override
  Widget build(BuildContext context) {
    Get.put(AddSongsContoller());

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
                  onTap: () {
                    final controller = Get.find<AddSongsContoller>();
                    controller.addSongsToPlaylist(index: index, playlistkey: playlistkey, playlistsongs: playlistsongs);
                    // audioRoom.addTo(RoomType.PLAYLIST,
                    //     playlistsongs[index].getMap.toSongEntity(),
                    //     playlistKey: playlistkey, ignoreDuplicate: false);
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text(
                            'Song Added to Playlist',
                            style: GoogleFonts.inter(color: Colors.white),
                          ),
                        ),
                      );
                    // setState(
                    //   () {},
                    // );
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
                    playlistsongs[index].title.toString(),
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  subtitle: Text(
                    "${playlistsongs[index].artist}",
                    style: const TextStyle(
                        fontSize: 13, height: 2, color: Colors.grey),
                  ),
                ),
                itemCount: playlistsongs.length,
              );
            },
        
      ),
    );
  }
}
