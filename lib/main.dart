import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:neon_player/tab_navigator.dart';

void main() {
 AssetsAudioPlayer.setupNotificationsOpenAction((notification) => true,);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: Typography(platform: TargetPlatform.android).white,
          canvasColor: Color(0xFF09131F),
          appBarTheme: const AppBarTheme(
            color: Color(0xFF181717),
          ),
          primarySwatch: Colors.blue),
      home: const TabNavigation(),
    );
  }
}
