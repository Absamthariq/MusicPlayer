import 'package:flutter/material.dart';
import 'package:neon_player/tracks_music_list/track_lists.dart';

// Widget listItems({
//   required title,
//   required artist,
//   required img,
//   required int index
// }) {
//    return listitems();
// }

class Listitems extends StatelessWidget
 {
   final int index;
  const Listitems({
    Key? key, required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        
        ListTile(
          leading: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFF181717),
              ),
            ),
            width: 56,
            height: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                 player.playlist!.audios[index].metas.image!.path,
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            player.playlist!.audios[index].metas.title!.toUpperCase(),
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),
          ),
          subtitle: Text(
            player.playlist!.audios[index].metas.artist!.toUpperCase(),
            style: const TextStyle(fontSize: 13, height: 2, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
