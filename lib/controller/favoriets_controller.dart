import 'package:get/get.dart';
import 'package:neon_player/favorists/favoricon.dart';
import 'package:neon_player/tracks_music_list/track_lists.dart';
import 'package:on_audio_room/on_audio_room.dart';

class FavoritesController extends GetxController {
  favoreitsSongRemove({
    required int index,
    required List favorites,
  }) async {
    await audioRoom.deleteFrom(
      RoomType.FAVORITES,
      favorites[index].key,
    );
    update();
  }
}
