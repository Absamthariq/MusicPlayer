import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

class AddSongsContoller extends GetxController {
  final OnAudioRoom audioRoom = OnAudioRoom();

  deleteFromPlaylist(
      {required int index,
      required int playlistkey,
      required List playlistsongs}) async {
    {
      await audioRoom.deleteFrom(RoomType.PLAYLIST, playlistsongs[index].id,
          playlistKey: playlistkey);
      update();
    }
  }

  addSongsToPlaylist({
    required int index,
    required int playlistkey,
    required List<SongModel> playlistsongs,}
  ) async {
    await audioRoom.addTo(
        RoomType.PLAYLIST, playlistsongs[index].getMap.toSongEntity(),
        playlistKey: playlistkey, ignoreDuplicate: false);
        update();
  }
  
}
