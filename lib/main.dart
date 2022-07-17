import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neon_player/db/songmodel.dart';
import 'package:neon_player/splash/splash.dart';
import 'package:neon_player/tracks_music_list/track_lists.dart';
import 'package:on_audio_room/on_audio_room.dart';

import 'db/songmodel.dart';

String boxname = 'songname';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await OnAudioRoom().initRoom();
  AssetsAudioPlayer.setupNotificationsOpenAction(
    (notification) => true,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SongsAdapter());
  await Hive.openBox<List>(boxname);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: Typography(platform: TargetPlatform.android).white,
          canvasColor: const Color(0xFF09131F),
          appBarTheme: const AppBarTheme(
            color: Color(0xFF181717),
          ),
          primarySwatch: Colors.blue),
      home: const SpalshScreen(),
    );
  }
}
