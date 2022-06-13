import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neon_player/tracks_music_list/track_lists.dart';
import 'package:on_audio_room/on_audio_room.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

playlistShowBottomSheet(BuildContext context) {
  return showModalBottomSheet(
      backgroundColor: Color(0xFF181717),
      context: context,
      builder: (ctx) {
        return PlaylistBottomSheetWidget();
      });
}

class PlaylistBottomSheetWidget extends StatefulWidget {
  const PlaylistBottomSheetWidget({Key? key}) : super(key: key);

  @override
  State<PlaylistBottomSheetWidget> createState() =>
      _PlaylistBottomSheetWidgetState();
}

class _PlaylistBottomSheetWidgetState extends State<PlaylistBottomSheetWidget> {
    final _formKey = GlobalKey<FormState>();
      TextEditingController playlistcontroller = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF181717),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25),
          bottomLeft: Radius.zero,
          bottomRight: Radius.zero,
        ),
      ),
      height: 400,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Stack(
          children: [
            FutureBuilder<List<PlaylistEntity>>(
              future: audioRoom.queryPlaylists(),
              builder: (context, item) {
                if (item.data == null || item.data!.isEmpty) {
                  return const Center(
                    child: Text(
                      'No Playlists Found',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }
                List<PlaylistEntity> playlist = item.data!;
                return player.builderCurrent(builder: (context, playing) {
                  return ListView.builder(
                    itemCount: playlist.length,
                    itemBuilder: (BuildContext context, index) {
                      return ListTile(
                        onTap: () {
                          audioRoom.addTo(RoomType.PLAYLIST,
                              allsongs[playing.index].getMap.toSongEntity(),
                              playlistKey: playlist[index].key,
                              ignoreDuplicate: false);
                          Navigator.pop(context);
                          setState(() {});
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green,
                                content: Text(
                                  'Song Added to Playlist',
                                  style:
                                      GoogleFonts.dmSans(color: Colors.white),
                                ),
                              ),
                            );
                        },
                        leading: const Icon(
                          Icons.playlist_add_circle,
                          size: 50,
                          color: Color(0xFFE9572F),
                        ),
                        title: Text(
                          item.data![index].playlistName,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          item.data![index].playlistSongs.length.toString() +
                              ' SONGS',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Colors.white),
                        ),
                      );
                    },
                  );
                });
              },
            ),
            //  floatting
            Container(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                onPressed: () {
                   showDialog<String>(
          barrierColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) => AlertDialog(
            backgroundColor: const Color.fromARGB(255, 67, 64, 64),
            title: Text(
              'CREATE NEW PLAYLIST',
              style: GoogleFonts.inter(
                letterSpacing: 1,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            actions: <Widget>[
              Form(
                key: _formKey,
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty || value == "") {
                      return 'Please Enter Some Text';
                    }
                    return null;
                  },
                  controller: playlistcontroller,
                  decoration: const InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    hintText: 'Enter Playlist Name...',
                    hintStyle: TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    audioRoom.createPlaylist(playlistcontroller.text);
                    playlistcontroller.clear();
                    Navigator.pop(context, 'Create');
                    setState(() {});
                  }
                },
                child: Text(
                  'CREATE',
                  style: GoogleFonts.inter(
                    color: Colors.white,fontWeight:FontWeight.w500
                  ),
                ),
              ),
            ],
          ),
        );
                },
                backgroundColor: Color(0xFF181717),
                child: Icon(Icons.add),
              ),
            )
          ],
        ),
      ),
    );
  }
}
