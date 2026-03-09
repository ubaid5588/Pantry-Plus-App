import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../screens/whole_screen.dart';
import '../screens/verification_email_screen.dart';
import '../screens/signin_screen.dart';
import '../providers/user_data_provider.dart';

class Wrapper extends StatefulWidget {
  static const String routeName = '/wrapper';
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  Future<void> _fetchUserData() async {
    await Provider.of<UserDataProvider>(context, listen: false)
        .checkUserAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('Error'),
              );
            } else {
              if (snapshot.data == null) {
                return const SigninScreen();
              } else {
                if (snapshot.data!.emailVerified == false) {
                  return const VerificationEmailScreen();
                }
                return FutureBuilder(
                  future: _fetchUserData(),
                  builder: (context, futureSnapshot) {
                    if (futureSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Center(
                        child: LoadingAnimationWidget.flickr(
                          leftDotColor: Colors.red,
                          rightDotColor: Colors.yellow,
                          size: 50,
                        ),
                      );
                    } else if (futureSnapshot.hasError) {
                      return const Center(
                        child: Text('Failed to fetch user data'),
                      );
                    } else {
                      return const WholeScreen();
                    }
                  },
                );
                // return const WholeScreen();
              }
            }
          }),
    );
  }
}
