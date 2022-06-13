import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neon_player/favorists/favourists.dart';
import 'package:neon_player/tracks_music_list/track_lists.dart';
import 'package:on_audio_room/on_audio_room.dart';

class FavoreitsIcon extends StatefulWidget {
  const FavoreitsIcon({Key? key}) : super(key: key);

  @override
  State<FavoreitsIcon> createState() => _FavoreitsIconState();
}

class _FavoreitsIconState extends State<FavoreitsIcon> {
  @override
  Widget build(BuildContext context) {
    return player.builderCurrent(builder: (context, playing) {
      return FutureBuilder<List<FavoritesEntity>>(
        future: audioRoom.queryFavorites(
          //limit: 50,
          reverse: false,
          sortType: null,
        ),
        builder: (context, allFavorite) {
          if (allFavorite.data == null) {
            return const SizedBox();
          }
          List<FavoritesEntity> favorites = allFavorite.data!;
          List<Audio> favSongs = [];
          for (var favrSongs in favorites) {
            favSongs.add(
              Audio.file(
                favrSongs.lastData,
                metas: Metas(
                  title: favrSongs.title,
                  artist: favrSongs.artist,
                  id: favrSongs.id.toString(),
                ),
              ),
            );
          }
          int currentIndex = playing.index;
          bool isFav = false;
          int? key;
          for (var fav in favorites) {
            if (songDetails[currentIndex].metas.title == fav.title) {
              isFav = true;
              key = fav.key;
            }
          }

          return IconButton(
              onPressed: () {
                if (!isFav) {
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        backgroundColor:
                          Colors.green  ,
                        content: Text(
                          "Added to Favorites!",
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  audioRoom.addTo(
                    RoomType.FAVORITES, //Specify Room Type
                    allsongs[currentIndex].getMap.toFavoritesEntity(),
                    ignoreDuplicate: false, //Avoid Same Song
                  );
                } else {
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                          "Removed From Favorites!",
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  audioRoom.deleteFrom(
                    RoomType.FAVORITES,
                    key!,
                  );
                  setState(() {});
                }
                setState(() {});
              },
              icon: Icon(
                Icons.favorite_border_outlined,
                color: isFav ? Colors.red : Colors.grey,
              ));
        },
      );
    });
  }
}
