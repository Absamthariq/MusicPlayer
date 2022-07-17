import 'dart:typed_data';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neon_player/controller/music_controll_controllers.dart';
import 'package:neon_player/db/songmodel.dart';
import 'package:neon_player/favorists/favoricon.dart';
import 'package:neon_player/now_playing/progress_bar.dart';
import 'package:neon_player/playlist/btmshtplaylists.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:palette_generator/palette_generator.dart';
import '../tracks_music_list/track_lists.dart';

class NowPlayer extends StatelessWidget {
  // final PaletteGenerator? palette;
  NowPlayer({
    Key? key,
  }) : super(key: key);

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  OnAudioQuery audioQuery = OnAudioQuery();
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer.withId("0");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return assetsAudioPlayer.builderCurrent(
      builder: (context, playing) {
        String songid = playing.audio.audio.metas.id!;
        bool isRepeate = false;
        bool isShuffle = false;

        return FutureBuilder<PaletteGenerator?>(
          future: generatePalette(songid),
          builder: (context, AsyncSnapshot<PaletteGenerator?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            PaletteGenerator? paletteGenerator = snapshot.data;

            Color bgColor = paletteGenerator == null
                ? Colors.black
                : snapshot.data!.dominantColor == null
                    ? Colors.black45
                    : snapshot.data!.dominantColor!.color;

            Color textColor = snapshot.data == null
                ? Colors.white60
                : snapshot.data!.mutedColor == null
                    ? snapshot.data!.dominantColor!.color
                    : snapshot.data!.mutedColor!.color;

            Color iconColor = snapshot.data == null
                ? Colors.white60
                : snapshot.data!.lightMutedColor == null
                    ? snapshot.data!.dominantColor!.color
                    : snapshot.data!.darkMutedColor!.color;
            // if(iconColor== bgColor){
            //   iconColor=textColor;
            // }

            //  if(icoColor== bgColor){
            //   iconColor=textColor;
            // }

            return Scaffold(
              backgroundColor: bgColor, //Color(0xFF0F2723),
              appBar: AppBar(
                elevation: 0,
                backgroundColor: bgColor,
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Column(
                  children: [
                    Text(
                      'PLAYING FROM',
                      style: GoogleFonts.inter(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 10),
                    ),
                    Text(
                      player.getCurrentAudioAlbum.toUpperCase(),
                      style: GoogleFonts.inter(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    )
                  ],
                ),
                leading: const FavoreitsIcon(),
                actions: [
                  IconButton(
                    onPressed: () {
                      // setState(() {});
                      playlistShowBottomSheet(context);
                    },
                    icon: Icon(
                      Icons.playlist_add,
                      color: Colors.grey[700],
                    ),
                  )
                ],
              ),
              body: Column(
                children: [
                  Container(
                    height: size.height * 0.55,
                    color: bgColor,
                    width: size.width,
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 0, 0, 0),
                            Color(0x00000000)
                          ],
                        ).createShader(
                          Rect.fromLTRB(0, 10, rect.width, rect.height),
                        );
                      },
                      blendMode: BlendMode.dstIn,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: QueryArtworkWidget(
                            // artworkQuality: FilterQuality.high,
                            quality: 100,
                            size: 2000,
                            keepOldArtwork: true,
                            artworkFit: BoxFit.cover,
                            artworkBorder: BorderRadius.circular(30),
                            id: int.parse(songid),
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: ClipRRect(
                              child: Image.asset(
                                'lib/assets/song_images/the-machine-dances-logo-stock-.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: bgColor,
                    height: size.height * 0.10,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          player.getCurrentAudioTitle,
                          style: GoogleFonts.inter(
                              fontSize: 17,
                              color: textColor,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: size.height * 0.01),
                        Text(
                          assetsAudioPlayer.getCurrentAudioArtist,
                          style: GoogleFonts.inter(
                              fontSize: 13,
                              color: textColor,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                  ProgressBarLine(),
                  Expanded(
                    child: Container(
                      color: bgColor,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ShuffleIcon(isShuffle),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                            child: IconButton(
                              onPressed: playing.index != 0
                                  ? () {
                                      player.previous();
                                    }
                                  : () {},
                              icon: playing.index == 0
                                  ? const Icon(
                                      Icons.skip_previous_outlined,
                                      color: Colors.black45,
                                      size: 28,
                                    )
                                  : Icon(
                                      CupertinoIcons.backward_end_fill,
                                      color: Colors.grey[700],
                                      size: 28,
                                    ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: iconColor,
                            radius: 40,
                            child: Center(
                              child: PlayerBuilder.isPlaying(
                                player: player,
                                builder: (context, isPlaying) {
                                  return IconButton(
                                    icon: Icon(
                                      isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      player.playOrPause();
                                    },
                                    color: Colors.white,
                                  );
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                            child: IconButton(
                              onPressed: playing.index == allsongs.length - 1
                                  ? () {}
                                  : () {
                                      player.next();
                                    },
                              icon: playing.index == allsongs.length - 1
                                  ? const Icon(
                                      CupertinoIcons.forward_end,
                                      color: Colors.black45,
                                      size: 28,
                                    )
                                  : Icon(
                                      CupertinoIcons.forward_end_fill,
                                      color: Colors.grey[700],
                                      size: 28,
                                    ),
                            ),
                          ),
                          RepeatIcon(isRepeate),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  ShuffleIcon(bool isShuffle) {
    return GetBuilder<MusicController>(
      init: MusicController(),
      builder: (controller) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(50)),
          child: IconButton(
            onPressed: controller.shuffleControll,
            icon: Icon(
              player.isShuffling.value
                  ? Icons.shuffle_on_outlined
                  : Icons.shuffle,
              color: Colors.grey[700],
              size: 20,
            ),
          ),
        );
      },
    );
  }
}

RepeatIcon(bool isRepeat) {
  return GetBuilder<MusicController>(builder: (controller) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.transparent, borderRadius: BorderRadius.circular(50)),
      child: IconButton(
        onPressed: controller.repeatControll,
        icon: Icon(
          !controller.isRepeat ? Icons.repeat : Icons.repeat_one,
          color: Colors.grey[700],
          size: 20,
        ),
      ),
    );
  });
}

Future<PaletteGenerator?> generatePalette(String songId) async {
  Uint8List? imagebyte =
      await audioQuery.queryArtwork(int.parse(songId), ArtworkType.AUDIO);

  PaletteGenerator? paletteGenerator = await PaletteGenerator.fromImageProvider(
      MemoryImage(imagebyte!),
      size: const Size(300, 150),
      maximumColorCount: 30);
  return paletteGenerator;
}

Songs databaseSongs(List<Songs> songs, String id) {
  return songs.firstWhere(
    (element) => element.songurl.toString().contains(id.toString()),
  );
}
