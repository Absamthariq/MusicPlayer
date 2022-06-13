import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF09131F),
        title: const Text('SETTINGS'),
      ),
      body: Column(
        children: [
          InkWell(
            child: const ListTile(
              leading: Icon(
                Icons.share,
                color: Colors.white,
              ),
              title: Text('Share this App'),
            ),
            onTap: () {},
          ),
          InkWell(
            child: ListTile(
              leading: const Icon(
                Icons.translate,
                color: Colors.white,
              ),
              title: const Text('Change Language'),
              onTap: () {},
            ),
          ),
          InkWell(
            child: const ListTile(
              leading: Icon(
                Icons.event_note_outlined,
                color: Colors.white,
              ),
              title: Text('Terms and Conditions'),
            ),
            onTap: () {},
          ),
          InkWell(
            child: const ListTile(
              leading: Icon(
                Icons.star,
                color: Colors.white,
              ),
              title: Text('Rate Us'),
            ),
            onTap: () {},
          ),
          InkWell(
            child: const ListTile(
              leading: Icon(
                Icons.info,
                color: Colors.white,
              ),
              title: Text('About Us'),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LicencePageSimple(),
                ),
              );
            },
          ),
          const Spacer(),
          const Text(
            'version',
            style: TextStyle(color: Colors.grey),
          ),
          const Text(
            '0.69',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}

class LicencePageSimple extends StatelessWidget {
  const LicencePageSimple({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: const LicensePage(
        applicationName: 'Neon player',
        applicationVersion: "Version 1.0.0\n\nCopyright © 2022-2023",
        applicationLegalese: "Developed by Absam Thariq Hassan",
      ),
    );
  }
}
