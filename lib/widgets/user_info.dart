// import 'dart:io';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import '../providers/auth_services.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

class Userinfo extends StatefulWidget {
  const Userinfo({super.key});

  @override
  State<Userinfo> createState() => _UserinfoState();
}

class _UserinfoState extends State<Userinfo> {
  final auth = AuthServices();

  // Future<void> uploadProfilePictureFromGallery() async {
  //   // Initialize the image picker
  //   final ImagePicker picker = ImagePicker();

  //   // Pick an image from the gallery
  //   final XFile? pickedImage =
  //       await picker.pickImage(source: ImageSource.gallery);

  //   if (pickedImage != null) {
  //     File imageFile = File(pickedImage.path);

  //     // Get the currently signed-in user
  //     User? user = FirebaseAuth.instance.currentUser;

  //     if (user != null) {
  //       String userId = user.uid; // Unique ID for the signed-in user
  //       // Upload the image to Firebase Storage
  //       Reference storageRef =
  //           FirebaseStorage.instance.ref().child('profile_pics/$userId.jpg');
  //       UploadTask uploadTask = storageRef.putFile(imageFile);
  //       TaskSnapshot snapshot = await uploadTask;
  //       // Get the download URL of the uploaded image
  //       String downloadURL = await snapshot.ref.getDownloadURL();

  //       // Save the download URL to Firestore under the user's document
  //       await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(userId)
  //           .update({
  //         'profilePicture': downloadURL,
  //       });
  //     }
  //   } else {}
  // }

  @override
  Widget build(BuildContext context) {
    // final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    User? user = FirebaseAuth.instance.currentUser;

    final String userName = user?.displayName ?? '? ?';
    final List<String> splitName = userName.split(' ');
    String initials = splitName.map((word) => word[0]).join();

    return ListTile(
      contentPadding: const EdgeInsets.all(14),
      leading: CircleAvatar(
        radius: deviceWidth * 0.08,
        child: Text(
          initials.toUpperCase(),
          style: TextStyle(fontSize: deviceWidth * 0.06),
        ),
      ),
      // leading: GestureDetector(
      //   onTap: uploadProfilePictureFromGallery,
      //   child: CircleAvatar(
      // radius: deviceWidth * 0.085,
      //     backgroundColor: Colors.white,
      //     child: FutureBuilder<DocumentSnapshot>(
      //       future: FirebaseFirestore.instance
      //           .collection('users')
      //           .doc(user!.uid)
      //           .get(),
      //       builder: (context, snapshot) {
      //         if (snapshot.connectionState == ConnectionState.waiting) {
      //           return const CircularProgressIndicator();
      //         } else if (snapshot.hasData) {
      //           var data = snapshot.data?.data() as Map<String, dynamic>?;
      //           if (data != null) {
      //             String? imageUrl = data['profilePicture'];
      //             if (imageUrl != null) {
      //               return ClipRRect(
      //                 borderRadius: BorderRadius.circular(deviceWidth * 0.083),
      //                 child: Image.network(
      //                   imageUrl,
      //                   height: deviceHeight * 0.07,
      //                   width: deviceWidth * 0.3,
      //                 ),
      //               ); // Display the image
      //             } else {
      //               return const Text(
      //                 "Set Profile",
      //                 style: TextStyle(fontSize: 12),
      //               );
      //             }
      //           } else {
      //             return Padding(
      //               padding: EdgeInsets.only(left: deviceWidth * 0.007),
      //               child: Text(
      //                 "Set Profile",
      //                 style: TextStyle(fontSize: deviceWidth * 0.03),
      //               ),
      //             );
      //           }
      //         } else {
      //           return Text(
      //             "network error",
      //             style: TextStyle(fontSize: deviceWidth * 0.03),
      //           );
      //         }
      //       },
      //     ),
      //   ),
      // ),
      title: Text(
        user?.displayName ?? 'User',
        // 'User',
        style: TextStyle(
            fontSize: deviceWidth * 0.052, fontWeight: FontWeight.w500),
      ),
      subtitle: Padding(
        padding: EdgeInsets.only(right: deviceWidth * 0.1),
        child: Text(
          user?.email ?? 'Unknown',
          // 'Unknown',
          style: TextStyle(fontSize: deviceWidth * 0.046),
        ),
      ),
    );
  }
}
