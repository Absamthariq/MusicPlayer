import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neon_player/db/songmodel.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';
import 'package:permission_handler/permission_handler.dart';

List<Songs> dbSongs = [];
final OnAudioRoom audioRoom = OnAudioRoom();

class TrackLists extends StatefulWidget {
  const TrackLists({Key? key}) : super(key: key);

  @override
  State<TrackLists> createState() => _TrackListsState();
}

AssetsAudioPlayer player = AssetsAudioPlayer.withId('0');

final OnAudioQuery audioQuery = OnAudioQuery();
List<SongModel> allsongs = [];
List<Audio> songDetails = [];
List<Songs> mappedSongs = [];

final box = Boxes.getInstance();

class _TrackListsState extends State<TrackLists> {
  @override
  void initState() {
    // songLists();

    requestPermission();
  }

  void requestPermission() async {
    Permission.storage.request();
    //Don't add the RoomType.

    allsongs = await audioQuery.querySongs();
    mappedSongs = allsongs
        .map((audio) => Songs(
            id: audio.id,
            artist: audio.artist,
            duration: audio.duration,
            songname: audio.title,
            songurl: audio.uri))
        .toList();

    await box.put("music", mappedSongs);
    dbSongs = box.get("music") as List<Songs>;

    for (var i in allsongs) {
      songDetails.add(
        Audio.file(
          i.uri.toString(),
          metas: Metas(
            title: i.title,
            id: i.id.toString(),
            artist: i.artist,
            album: i.album,
          ),
        ),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181717),
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
//  allsongs=item.data!;
          return ListView.builder(
            itemBuilder: (context, index) => ListTile(
              onTap: () async {
                await player.open(
                  Playlist(
                    audios: songDetails,
                    startIndex: index,
                  ),
                  showNotification: true,
                  notificationSettings:
                      const NotificationSettings(stopEnabled: false),
                  autoStart: true,
                  loopMode: LoopMode.playlist,
                  playInBackground: PlayInBackground.enabled,
                );
              },
              onLongPress: () {
                audioRoom.addTo(
                  RoomType.FAVORITES, // Specify the room type
                  item.data![index].getMap.toFavoritesEntity(),
                  ignoreDuplicate: false, // Avoid the same song
                );
                ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                          backgroundColor: Colors.green ,
                          content: Text(
                            'Added to Favorites.',
                            style: GoogleFonts.inter(color: Colors.white),
                          ),
                        ));
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
              subtitle: Text("${item.data![index].artist}",
                  style: const TextStyle(
                      fontSize: 13, height: 2, color: Colors.grey)),
            ),
            itemCount: item.data!.length,
          );
        },
      ),
    );
  }
}
