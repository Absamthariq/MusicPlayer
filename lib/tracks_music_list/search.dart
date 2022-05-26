import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neon_player/now_playing/now_player.dart';
import 'package:neon_player/tracks_music_list/openPlayer.dart';
import 'package:neon_player/tracks_music_list/track_lists.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchScreen extends SearchDelegate{

List<String> allData =[''];

  @override
  List<Widget>? buildActions(BuildContext context) {
   return [
      IconButton(
        color: Colors.grey,
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = '';
          }
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return theme.copyWith(
      hintColor: Colors.grey,
      appBarTheme: const AppBarTheme(
        color: Color.fromARGB(255, 221, 255, 252),
      ),
      inputDecorationTheme: searchFieldDecorationTheme ??
          const InputDecorationTheme(
              border: InputBorder.none, fillColor: Colors.black),
    );
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.grey,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Text(
        query,
        style: GoogleFonts.nunito(
          fontSize: 20,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  @override
  Widget buildSuggestions(BuildContext context) {
    final searchSongItem = query.isEmpty
        ? songDetails
        : songDetails
                .where(
                  (element) => element.metas.title!.toLowerCase().contains(
                        query.toLowerCase().toString(),
                      ),
                )
                .toList() +
            songDetails
                .where(
                  (element) => element.metas.artist!.toLowerCase().contains(
                        query.toLowerCase().toString(),
                      ),
                )
                .toList();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 221, 255, 252),
      body: searchSongItem.isEmpty
          ? Center(
              child: Text(
                "No Songs Found",
                style: GoogleFonts.nunito(
                  fontSize: 20,
                  letterSpacing: 1,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          : ListView.builder(
            itemBuilder: (context, index) =>  ListTile(
                        onTap: (() async {
                          await OpenPlayer(
                            fullSongs: [],
                            index: index,
                          ).openAssetPlayer(
                            index: index,
                            songs: searchSongItem,
                          );
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: ((context) => const NowPlayer()),
                            ),
                          );
                        }),
              leading: QueryArtworkWidget(
                id: int.parse(searchSongItem[index].metas.id!),
                type: ArtworkType.AUDIO,
                nullArtworkWidget: ClipRRect(
                   borderRadius: BorderRadius.circular(30),
                  child: Image.asset(
                    'lib/assets/song_images/the-machine-dances-logo-stock-.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text( searchSongItem[index].metas.title!,style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white)),
              subtitle: Text(searchSongItem[index].metas.artist!,style: const TextStyle(fontSize: 13, height: 2, color: Colors.grey)),
            ),
            itemCount: searchSongItem.length,
          )
    );
  }
  
}