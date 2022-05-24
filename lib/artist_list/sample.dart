import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SampleTrail extends StatelessWidget {
  const SampleTrail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 18,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, crossAxisSpacing: 0, childAspectRatio: 28 / 40),
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
        
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.amber,
                  image: DecorationImage(
                      image: AssetImage('lib/assets/song_images/ARIANA.jfif'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  
                  color: Colors.amber,
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
