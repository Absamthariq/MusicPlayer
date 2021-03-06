import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neon_player/albums_list/album_list.dart';
import 'package:neon_player/artist_list/artist_lists.dart';
import 'package:neon_player/drawer/drawer.dart';
import 'package:neon_player/favorists/favourists.dart';
import 'package:neon_player/Miniplayer/miniplayer2.dart';
import 'package:neon_player/playlist/playlists.dart';
import 'package:neon_player/tracks_music_list/search.dart';
import 'package:neon_player/tracks_music_list/track_lists.dart';

class TabNavigation extends StatelessWidget {
  const TabNavigation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        bottomSheet:  Miniplayer2(),
        backgroundColor: const Color(0xFF181717),
        drawer: const DrawerList(),
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchScreen());
              },
              icon: const Icon(Icons.search),
            ),
          ],
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            tabs: [
              Tab(
                text: 'TRACKS',
              ),
              Tab(
                text: 'ALBUMS',
              ),
              Tab(
                text: 'ARTIST',
              ),
              Tab(
                text: 'PLAYLIST',
              ),
              Tab(
                text: 'FAVOURITES',
              ),
            ],
          ),
          title: Text(
            'Library',
            style: GoogleFonts.inter(fontSize: 25, fontWeight: FontWeight.w700),
          ),
        ),
        body:  TabBarView(
          children: [
            TrackLists(),
            AlbumPage(),
            ArtistLists(),
            Playlists(),
            Favourites(),
          ],
        ),
      ),
    );
  }
}
