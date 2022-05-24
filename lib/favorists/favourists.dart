import 'package:flutter/material.dart';
import 'package:neon_player/favorists/favourists_list.dart';

class Favourites extends StatelessWidget {
  const Favourites({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: favourlists(),
        );
      },
    );
  }
}