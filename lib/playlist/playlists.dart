import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neon_player/controller/playlist_controller.dart';
import 'package:neon_player/playlist/songs_in_playlists.dart';
import 'package:neon_player/tracks_music_list/track_lists.dart';
import 'package:on_audio_room/on_audio_room.dart';

class Playlists extends StatelessWidget {
  Playlists({Key? key}) : super(key: key);

  TextEditingController playlistcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Get.put(PlaylistController());
    return Column(children: [
      createPL(context),
      Expanded(
        child: GetBuilder<PlaylistController>(
          builder: (controller) {
            return FutureBuilder<List<PlaylistEntity>>(
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
                return ListView.builder(
                  itemCount: playlist.length,
                  itemBuilder: (BuildContext context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: GestureDetector(
                        onTap: () async {
                          await Navigator.of(context).push(MaterialPageRoute(
                              builder: ((context) => PlaylistSongs(
                                  playlistName: item.data![index].playlistName,
                                  playlistkey: item.data![index].key))));
                                  controller.update();
                          // setState(() {});
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          child: Row(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'lib/assets/song_images/playlist.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 230,
                                height: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 0, 0, 0),
                                      child: Text(
                                        item.data![index].playlistName,
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 5, 0, 0),
                                      child: Text(
                                        item.data![index].playlistSongs.length
                                                .toString() +
                                            ' SONGS',
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  PopupMenuButton(
                                    color: const Color(0xFF181717),
                                    icon: const Icon(
                                      Icons.more_vert_outlined,
                                      color: Colors.white,
                                    ),
                                    itemBuilder: (context) => [
                                      PopupMenuItem(
                                        onTap: () {},
                                        value: "0",
                                        child: const Text(
                                          "Rename Playlist",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      PopupMenuItem(
                                        onTap: () {},
                                        value: "1",
                                        child: const Text(
                                          "Remove Playlist",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ],
                                    onSelected: (value) {
                                      if (value == "1") {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                            backgroundColor:
                                                const Color(0xFF181717),
                                            title: Text(
                                              'Delete Playlist?',
                                              style: GoogleFonts.dmSans(
                                                  color: Colors.white),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                child: Text('Yes',
                                                    style: GoogleFonts.inter(
                                                      color: Colors.white,
                                                    )),
                                                onPressed: () {
                                                  // Get.back();
                                                  final controller = Get.find<
                                                      PlaylistController>();
                                                  controller.deletePlaylist(
                                                      item.data![index].key);

                                                  Navigator.of(context).pop();
                                                  // audioRoom.deletePlaylist(
                                                  //     item.data![index].key);
                                                  //       Navigator.of(context).pop();
                                                  // setState(()
                                                  //  {
                                                  //   Navigator.of(context).pop();
                                                  // });
                                                },
                                              ),
                                              TextButton(
                                                child: Text('No',
                                                    style: GoogleFonts.inter(
                                                      color: Colors.white,
                                                    )),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      )
    ]);
  }

  ElevatedButton createPL(context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.grey[700],
        onPrimary: Colors.white,
        shadowColor: Colors.grey,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1.0)),
        minimumSize: const Size(400, 50), //////// HERE
      ),
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
                    // audioRoom.createPlaylist(playlistcontroller.text);
                    final controller = Get.find<PlaylistController>();
                    controller.creatingPlaylistName(playlistcontroller.text);
                    playlistcontroller.clear();
                    Navigator.pop(context, 'Create');
                    // setState(() {});
                  }
                },
                child: Text(
                  'CREATE',
                  style: GoogleFonts.inter(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'CREATE NEW PLAYLIST ',
            style: GoogleFonts.inter(
              letterSpacing: 1,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Icon(Icons.playlist_add_circle)
        ],
      ),
    );
  }
}
