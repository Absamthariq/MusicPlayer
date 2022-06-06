// import 'package:flutter/material.dart';
// import 'package:neon_player/db/songs_models.dart';

// class CreatePlaylist extends StatefulWidget {
//   const CreatePlaylist({ Key? key }) : super(key: key);

//   @override
//   State<CreatePlaylist> createState() => _CreatePlaylistState();
// }


// class _CreatePlaylistState extends State<CreatePlaylist> {
//   @override
//   Widget build(BuildContext context) {
//      List<Songs> playlist = [];
//     final box = StorageBox.getInstance();
//     String? title;
//     final formKey = GlobalKey<FormState>();

//     return AlertDialog(
//       backgroundColor: const Color(0xFF181717),
//       alignment: Alignment.center,
//       title: Text(
//         "Name Your Playlist",
//         style: TextStyle(color: Colors.white),
//       ),

//       // form validation
//       content: Form(
//         key: formKey,
//         child: TextFormField(
//             onChanged: (value) {
//               title = value.trim();
//             },
//             validator: (value) {
//               List keys = box.keys.toList();
//               if (value!.trim() == "") {
//                 return "Name Required";
//               }
//               if (keys.where((element) => element == value.trim()).isNotEmpty) {
//                 return "This Name Already Exist";
//               }
//               return null;
//             },
//             style: const TextStyle(color: Colors.white),
//             decoration: const InputDecoration(
//               focusedBorder:  OutlineInputBorder(
//                   borderSide:  BorderSide(color: Colors.grey)
//                   ),
//               // fillColor: Colors.white,
//               hintText: 'Playlist Name',
//               hintStyle:  TextStyle(color: Colors.grey),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey,),
//               ),
//             )),
//       ),
//       actions: [
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               TextButton(
//                 child: const Text("Cancel",
//                     style: TextStyle(color: Colors.white, fontSize: 16)),
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//               ),

//               // add playlist from db
//               TextButton(
//                 child: const Text("Create",
//                     style: TextStyle(color: Colors.white, fontSize: 16)),
//                 onPressed: () {
//                   if (formKey.currentState!.validate()) {
//                     box.put(title, playlist);
//                     Navigator.pop(context);
//                     setState(() {});
//                   }
//                 },
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }