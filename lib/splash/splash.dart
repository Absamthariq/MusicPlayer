import 'dart:async';

import 'package:flutter/material.dart';
import 'package:neon_player/tab_navigator.dart';
import 'package:neon_player/tracks_music_list/track_lists.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({Key? key}) : super(key: key);

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => const TabNavigation(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox(
          height: 250,
          width: 250,
          child: Image(image: AssetImage('lib/assets/song_images/logo2crop.jpg')),
        ),
      ),
    );
  }
}
