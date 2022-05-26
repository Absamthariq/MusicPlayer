import 'dart:typed_data';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neon_player/now_playing/progress_bar.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:palette_generator/palette_generator.dart';
import '../tracks_music_list/track_lists.dart';

class NowPlayer extends StatefulWidget {
  // final PaletteGenerator? palette;
  const NowPlayer({
    Key? key,
  }) : super(key: key);

  @override
  State<NowPlayer> createState() => _NowPlayerState();
}

Audio find(List<Audio> source, String fromPath) {
  return source.firstWhere((element) => element.path == fromPath);
}

class _NowPlayerState extends State<NowPlayer>
    with SingleTickerProviderStateMixin {
  OnAudioQuery audioQuery = OnAudioQuery();
  AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer.withId("0");

  @override
  Widget build(BuildContext context) {
    return assetsAudioPlayer.builderCurrent(builder: (context, playing) {
      final myAudio = find(songDetails, playing.audio.assetAudioPath);

      String songid = myAudio.metas.id!;

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
              : snapshot.data!.darkVibrantColor == null
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
                    myAudio.metas.album!.toUpperCase(),
                    style: GoogleFonts.inter(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  )
                ],
              ),
              leading: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite,
                  color: Color(0xFFE9572F),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.playlist_add,
                    color: Color(0xFFE9572F),
                  ),
                )
              ],
            ),
            body:
                Column(
              children: [
                Container(
                  // decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.all(Radius.circular(5))),
                  height: 500,
                  color: bgColor,
                  width: MediaQuery.of(context).size.width,
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
                  height: 100,
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
                      const SizedBox(height: 5),
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
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.shuffle,
                            size: 20,
                            color: Color(0xFFE9572F),
                          ),
                        ),
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
                                    Icons.skip_previous_rounded,
                                    color: Colors.black45,
                                    size: 35,
                                  )
                                : const Icon(
                                    CupertinoIcons.backward_end,
                                    color: Color(0xFFE9572F),
                                    size: 35,
                                  ),
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                              color: iconColor,
                              borderRadius: BorderRadius.circular(50)),
                          child: PlayerBuilder.isPlaying(
                            player: player,
                            builder: (context, isPlaying) {
                              return IconButton(
                                icon: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                  size: 43,
                                ),
                                onPressed: () {
                                  player.playOrPause();
                                },
                                color: Colors.white,
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                          child: IconButton(
                            iconSize: 45,
                            onPressed: playing.index == allsongs.length - 1
                                ? () {}
                                : () {
                                    player.next();
                                  },
                            icon: playing.index == allsongs.length - 1
                                ? const Icon(
                                    CupertinoIcons.forward_end,
                                    color: Colors.black45,
                                    size: 35,
                                  )
                                : const Icon(
                                    CupertinoIcons.forward_end,
                                    color: Color(0xFFE9572F),
                                    size: 35,
                                  ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.repeat,
                            size: 20,
                            color: Color(0xFFE9572F),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      );
    });
  }

  Future<PaletteGenerator?> generatePalette(String songId) async {
    Uint8List? imagebyte =
        await audioQuery.queryArtwork(int.parse(songId), ArtworkType.AUDIO);

    PaletteGenerator? paletteGenerator =
        await PaletteGenerator.fromImageProvider(MemoryImage(imagebyte!),
            size: const Size(300, 150), maximumColorCount: 30);
    return paletteGenerator;
  }
}
