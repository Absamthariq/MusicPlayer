import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:neon_player/drawer/settings.dart';

class DrawerList extends StatelessWidget {
  const DrawerList({ Key? key, ListView? child, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                child: Text(''),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  image: DecorationImage(
                      image: AssetImage('lib/assets/song_images/logo2.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
              ListTile(
                title: Text(
                  'RECENTLY PLAYED',
                  style: GoogleFonts.inter(
                      color: const Color.fromARGB(255, 231, 226, 226),
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  'EQUALIZER',
                  style: GoogleFonts.inter(
                      color: const Color.fromARGB(255, 231, 226, 226),
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text(
                  'SETTINGS',
                  style: GoogleFonts.inter(
                      color: const Color.fromARGB(255, 231, 226, 226),
                      fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Settings()),
                  );
                },
              ),
            ],
          ),
        );
  }
}