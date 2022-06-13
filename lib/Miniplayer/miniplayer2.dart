import 'dart:typed_data';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:neon_player/now_playing/now_player.dart';
import 'package:neon_player/tracks_music_list/track_lists.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:palette_generator/palette_generator.dart';

class Miniplayer2 extends StatefulWidget {
  const Miniplayer2({Key? key}) : super(key: key);

  @override
  State<Miniplayer2> createState() => _Miniplayer2State();
}

Audio find(List<Audio> source, String fromPath) {
  return source.firstWhere((element) => element.path == fromPath);
}

class _Miniplayer2State extends State<Miniplayer2> {
  PaletteGenerator? paletteGenerator;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: player.builderCurrent(
        builder: ((context, playing) {
          String songid = playing.audio.audio.metas.id!;

          return FutureBuilder<PaletteGenerator?>(
              future: updatePaletteGenerator(songid),
              builder: (context, AsyncSnapshot<PaletteGenerator?> snapshot) {
                PaletteGenerator? paletteGenerator = snapshot.data;

                Color bgColor = paletteGenerator == null
                    ? Colors.black
                    : snapshot.data!.dominantColor == null
                        ? Colors.black45
                        : snapshot.data!.dominantColor!.color;

                return Container(
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(0)),
                  child: ListTile(
                    onTap: () async {
                      // final palettes = await generatePalette('');

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NowPlayer(),
                        ),
                      );
                    },
                    tileColor: bgColor,
                    leading: QueryArtworkWidget(
                      id: int.parse(songid),
                      type: ArtworkType.AUDIO,
                      nullArtworkWidget: ClipRRect(
                        child: Image.asset(
                          'lib/assets/song_images/wave.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: SizedBox(
                      height: 18,
                      child: Text(
                        player.getCurrentAudioTitle,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    subtitle: Text(
                      player.getCurrentAudioArtist.toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        //  previous
                        IconButton(
                          onPressed: playing.index != 0
                              ? () {
                                  player.previous();
                                }
                              : () {},
                          icon: playing.index == 0
                              ? const Icon(
                                  Icons.skip_previous_rounded,
                                  color: Colors.black45,
                                  size: 43,
                                )
                              : const Icon(
                                  Icons.skip_previous_rounded,
                                  color: Colors.white,
                                  size: 43,
                                ),
                        ),
                        // play pause
                        PlayerBuilder.isPlaying( 
                          player: player,
                          builder: (context, isPlaying) {
                            return IconButton(
                              icon: Icon(
                                isPlaying
                                    ? Icons.pause_circle
                                    : Icons.play_circle,
                                size: 43,
                              ),
                              onPressed: () {
                                player.playOrPause();
                              },
                              color: Colors.white,
                            );
                          },
                        ),

                        // next
                        IconButton(
                          iconSize: 43,
                          onPressed: () {
                            player.next();
                          },
                          icon: const Icon(
                            Icons.skip_next_rounded,
                            color: Colors.white,
                            size: 43,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        }),
      ),
    );
  }

  Future<PaletteGenerator?> updatePaletteGenerator(String songid) async {
     Uint8List? imagebyte = await audioQuery.queryArtwork(
        int.parse(songid), 
        ArtworkType.AUDIO, 
        
      );
    paletteGenerator = await PaletteGenerator.fromImageProvider(MemoryImage(imagebyte!),
            size: const Size(300, 150), maximumColorCount: 30);
    return paletteGenerator;
  }
}
