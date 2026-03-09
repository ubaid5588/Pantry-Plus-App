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

  @override
  Widget build(BuildContext context) {
    // final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    User? user = FirebaseAuth.instance.currentUser;

    // final String userName = user?.displayName ?? '? ?';
    // final List<String> splitName = userName.split(' ');
    // String initials = splitName.map((word) => word[0]).join();
    final String userName = user?.displayName?.trim() ?? '';
    String initials = 'U';

    if (userName.isNotEmpty) {
      final parts = userName.split(' ').where((e) => e.isNotEmpty).toList();

      if (parts.isNotEmpty) {
        initials = parts
            .take(2) // max 2 letters
            .map((e) => e[0].toUpperCase())
            .join();
      }
    }

    return ListTile(
      contentPadding: const EdgeInsets.all(14),
      leading: CircleAvatar(
        radius: deviceWidth * 0.08,
        child: Text(
          initials.toUpperCase(),
          style: TextStyle(fontSize: deviceWidth * 0.06),
        ),
      ),

      title: Text(
        user?.displayName ?? 'User',
        // 'User',
        style: TextStyle(
          fontSize: deviceWidth * 0.052,
          fontWeight: FontWeight.w500,
        ),
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
