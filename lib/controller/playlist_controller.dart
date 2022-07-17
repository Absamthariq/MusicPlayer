import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

class PlaylistController extends GetxController {
  OnAudioRoom audioRoom = OnAudioRoom();

  // updateScreen() {
  //   update();
  // }

  creatingPlaylistName(value) {
    audioRoom.createPlaylist(value);
    // playlistName = value;
    update();
  }

  deletePlaylist(int playlistKey) {
    audioRoom.deletePlaylist(playlistKey);
    update();
  }

  addSongToListOfPlaylist(
      {required int index,
      required int playlistkey,
      required Playing playing,
      required List<SongModel> allsongs}) {
    audioRoom.addTo(
        RoomType.PLAYLIST, allsongs[playing.index].getMap.toSongEntity(),
        playlistKey: playlistkey, ignoreDuplicate: false);
        update();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
