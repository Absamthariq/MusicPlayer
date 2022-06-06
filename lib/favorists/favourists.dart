import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neon_player/tracks_music_list/track_lists.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/details/rooms/favorites/favorites_entity.dart';
import 'package:on_audio_room/on_audio_room.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  List<Audio> favSongsList = [];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<FavoritesEntity>>(
          future: audioRoom.queryFavorites(
            limit: 50,
            reverse: false,
            sortType: null,
          ),
          builder: (context, item) {
            if (item.data == null || item.data!.isEmpty) {
              return Text(
                "No Favorites found!",
                style: GoogleFonts.raleway(color: Colors.white),
              );
            }
            List<FavoritesEntity> favorites = item.data!;
              List<Audio> favoritesSongs = [];

            for (var songs in favorites) {
              favoritesSongs.add(
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
              itemCount: favorites.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () async {
                      await player.open(
                          Playlist(audios: favoritesSongs, startIndex: index),
                          showNotification: true,
                          loopMode: LoopMode.playlist,
                          notificationSettings:
                              const NotificationSettings(stopEnabled: false));
                    },
                  onLongPress: () async {
                    await RemoveFromfavorites(context, favorites, index);
                  },
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
                    favorites[index].title,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                  subtitle: Text(
                    favorites[index].artist.toString(),
                    style: const TextStyle(
                        fontSize: 13, height: 2, color: Colors.grey),
                  ),
                  trailing: IconButton(
                      onPressed: () async {
                        await RemoveFromfavorites(context, favorites, index);
                      },
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.greenAccent,
                      )),
                );
              },
            );
          }),
    );
  }

  RemoveFromfavorites(
      BuildContext context, List<FavoritesEntity> favorites, int index) {
    showDialog<String>(
      barrierColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: const Color(0xFF181717),
        content: Text('Remove from Favorites',
            style: GoogleFonts.inter(color: Colors.white)),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child:
                Text('Cancel', style: GoogleFonts.inter(color: Colors.white)),
          ),
          TextButton(
            onPressed: () async {
              await audioRoom.deleteFrom(
                RoomType.FAVORITES,
                favorites[index].key,
              );
              setState(() {});
              Navigator.pop(context, 'OK');
            },
            child: Text(
              'OK',
              style: GoogleFonts.inter(color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}
