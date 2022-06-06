// import 'package:flutter/material.dart';
// import 'package:neon_player/db/songs_models.dart';

// class UpdatePlaylist extends StatelessWidget {
//     String playlistName;

//    UpdatePlaylist({ Key? key,required this.playlistName}) : super(key: key);
//     final box = StorageBox.getInstance();
//   String? title;
//   final formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: const Color(0xFF181717),
//       title: const Center(
//           child: Text(
//         'Edit Your Playlist Name',
//         style: TextStyle(color: Colors.white),
//       )),
//       // update
//       content: Form(
//         key: formKey,
//         child: TextFormField(
//           initialValue: playlistName,
//           style: TextStyle(color: Colors.white),
//           onChanged: (value) {
//             title = value.trim();
//           },
//           validator: (value) {
//             final keys = box.keys.toList();
//             if (value!.trim() == "") {
//               return "Name Required";
//             }
//             return null;
//           },
//           decoration: const InputDecoration(
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey)
//               ),
//               enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.grey)),
//               fillColor: Colors.white),
//         ),
//       ),
//       actions: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               TextButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Text(
//                     'Cancel',
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                   )),
//               TextButton(
//                   onPressed: () {
//                     if (formKey.currentState!.validate()) {
//                       List? curentPlaylistName = box.get(playlistName);
//                       box.put(title, curentPlaylistName!);
//                       box.delete(playlistName);
//                       Navigator.pop(context);
//                     }
//                     ScaffoldMessenger.of(context).showSnackBar( SnackBar(
//                         behavior: SnackBarBehavior.floating,
//                         backgroundColor: Colors.grey[700],
//                         margin: EdgeInsets.all(10),
//                         content: Text('Playlist Updated.')));
//                   },
//                   child: const Text(
//                     'Confirm',
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                   ))
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }