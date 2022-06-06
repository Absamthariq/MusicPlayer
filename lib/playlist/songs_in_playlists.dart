import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neon_player/Miniplayer/miniplayer2.dart';
import 'package:neon_player/db/songmodel.dart';
import 'package:neon_player/now_playing/now_player.dart';
import 'package:neon_player/playlist/show_addable_music.dart';
import 'package:neon_player/tracks_music_list/openPlayer.dart';
import 'package:neon_player/tracks_music_list/track_lists.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

class PlaylistSongs extends StatefulWidget {
  String playlistName;
  int playlistkey;

  PlaylistSongs(
      {Key? key, required this.playlistName, required this.playlistkey})
      : super(key: key);

  @override
  State<PlaylistSongs> createState() => PlaylistSongsState();
}

class PlaylistSongsState extends State<PlaylistSongs> {
  List<Songs> playlistSongs = [];
  List<Audio> songInPlaylist = [];
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: const Miniplayer2(),
      backgroundColor: const Color(0xFF181717),
      appBar: AppBar(
        backgroundColor: const Color(0xFF181717),
        title: Text(widget.playlistName),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.0, top: 8),
            child: IconButton(
              onPressed: () async {
                await Navigator.of(context).push(MaterialPageRoute(
                    builder: ((context) => SelectSongsToPlaylist(
                          playlistkey: widget.playlistkey,
                        ))));
                setState(() {});
              },
              icon: const Icon(Icons.add_sharp),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder<List<SongEntity>>(
            future: OnAudioRoom().queryAllFromPlaylist(widget.playlistkey),
            builder: (context, item) {
              if (item.data == null || item.data!.isEmpty) {
                return Text(
                  "No Songs Added!",
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                );
              }
              List<SongEntity> playlistsongs = item.data!;

              List<Audio> play_PlaylistSongs = [];

              for (var songs in playlistsongs) {
                play_PlaylistSongs.add(
                  Audio.file(
                    songs.lastData,
                    metas: Metas(
                      title: songs.title,
                      artist: songs.artist,
                      id: songs.id.toString(),
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: item.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    onLongPress: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          backgroundColor: const Color(0xFF181717),
                          title: Text(
                            'Remove from Playlist?',
                            style: GoogleFonts.dmSans(color: Colors.white),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('Yes',
                                  style: GoogleFonts.inter(
                                    color: Colors.white,
                                  )),
                              onPressed: () async {
                                await audioRoom.deleteFrom(
                                    RoomType.PLAYLIST, playlistsongs[index].id,
                                    playlistKey: widget.playlistkey);
                                Navigator.of(context).pop();
                                setState(() {});
                              },
                            ),
                            TextButton(
                              child: Text(
                                'No',
                                style: GoogleFonts.inter(
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                    onTap: () async {
                      await player.open(
                          Playlist(audios: play_PlaylistSongs, startIndex: index),
                          showNotification: true,
                          loopMode: LoopMode.playlist,
                          notificationSettings:
                              const NotificationSettings(stopEnabled: false));
                    },
                    leading: QueryArtworkWidget(
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
                    title: Text(item.data![index].title.toString(),
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.white)),
                    subtitle: Text(
                      "${item.data![index].artist}",
                      style: const TextStyle(
                          fontSize: 13, height: 2, color: Colors.grey),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
