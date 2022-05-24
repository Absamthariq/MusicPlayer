import 'package:flutter/material.dart';

Widget favourlists(){
  return Column(
    children: [
      GestureDetector(
        onTap: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const Order545()),
          // );
        },
        child: ListTile(
          leading: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFF181717),
              ),
            ),
            width: 60,
            height: 60,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'lib/assets/song_images/POSTMALONE.jpg',
                fit: BoxFit.fill,
              ),
            ),
          ),
          title: const Text(
            'Favourited song will appear here',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500,color: Colors.white),
          ),
          subtitle: const Text(
            'Artist name will appear here',
            style: TextStyle(fontSize: 13, height: 2,color: Colors.grey),
          ),
          trailing: IconButton(onPressed: (){}, icon: Icon(Icons.favorite,color: Colors.greenAccent,)),
        ),
      ),
     
    ],
  );
}