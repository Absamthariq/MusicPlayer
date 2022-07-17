import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neon_player/Miniplayer/miniplayer2.dart';
import 'package:neon_player/tracks_music_list/track_lists.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtistDetailedList extends StatelessWidget {
  const ArtistDetailedList({
    Key? key,
    required this.artistId,
    required this.artistName,
  }) : super(key: key);

  final int artistId;
  final String artistName;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      bottomSheet: Miniplayer2(),
      body: FutureBuilder<List<SongModel>>(
        future: audioQuery.queryAudiosFrom(AudiosFromType.ARTIST_ID, artistId,
            sortType: SongSortType.TITLE),
        builder: (context, AsyncSnapshot<List<SongModel>> item) {
          return ListView(
            shrinkWrap: true,
            children: [
              Container(
                color: Colors.amber,
                height: size.height * 0.4,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(0),
                  child: QueryArtworkWidget(
                    id: artistId,
                    type: ArtworkType.ARTIST,
                    artworkFit: BoxFit.cover,
                    artworkBorder: BorderRadius.circular(0),
                    quality: 100,
                    size: 400,
                    nullArtworkWidget: ClipRRect(
                      child: Image.asset(
                        'lib/assets/song_images/the-machine-dances-logo-stock-.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: size.height * 0.06,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    artistName,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                )),
              ),
              ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: item.data!.length,
                itemBuilder: (context, index) {
                  SongModel songModel = item.data![index];
                  List<Audio> albumlistSongs = [];

                  for (var songs in item.data!) {
                    albumlistSongs.add(
                      Audio.file(
                        songs.uri.toString(),
                        metas: Metas(
                          title: songs.title,
                          artist: songs.artist,
                          id: songs.id.toString(),
                        ),
                      ),
                    );
                  }
                  return ListTile(
                    onTap: () async {
                      await player.open(
                          Playlist(audios: albumlistSongs, startIndex: index),
                          showNotification: true,
                          loopMode: LoopMode.playlist,
                          notificationSettings:
                              const NotificationSettings(stopEnabled: false));
                    },
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text('${index + 1}'),
                        ),
                      ],
                    ),
                    title: Text(songModel.title),
                    subtitle: Text(songModel.artist ?? 'unknown'),
                  );
                },
              )
            ],
          );
        },
      ),
    );
  }
}
