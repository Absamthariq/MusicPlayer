import 'package:hive_flutter/hive_flutter.dart';
import 'package:neon_player/main.dart';
part 'songmodel.g.dart';

@HiveType(typeId: 8)
class Songs extends HiveObject {
  @HiveField(0)
  String? artist;
  @HiveField(1)
  String? songname;
  @HiveField(2)
  int? duration;
  @HiveField(3)
  String? songurl;
  @HiveField(4)
  int? id;
  Songs(
      { this.id,
       this.artist,
       this.duration,
       this.songname,
       this.songurl});
}

class Boxes {
  static Box<List>getInstance(){
    return Hive.box<List>(boxname);
  }
}
