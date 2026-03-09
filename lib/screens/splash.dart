import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/wrapper.dart';

class Splash extends StatefulWidget {
  static const String routeName = '/splash';
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    navigateToLogin();
  }

  Future navigateToLogin() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacementNamed(Wrapper.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 241, 229, 229).withOpacity(0.9),
        ),
        child: Column(children: [
          SizedBox(
            width: double.infinity,
            height: deviceHeight * 0.34,
            child: Stack(
              children: [
                ClipRRect(
                  child: Image.asset('assets/images/topimage1.png'),
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                  child: const SizedBox(
                    width: double.infinity,
                    height: 100,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              width: double.infinity,
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 7.3, 22),
                      child: SizedBox(
                        width: 160,
                        height: deviceHeight * 0.17,
                        child: Image.asset(
                          'assets/images/logo.png',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 0, 20.7),
                      child: Text(
                        'Pantry Plus',
                        style: GoogleFonts.getFont(
                          'Poppins',
                          fontWeight: FontWeight.w500,
                          fontSize: 25,
                          color: const Color(0xFF37474F),
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Text(
                        'make your shopping easy',
                        style: GoogleFonts.getFont(
                          'Poppins',
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w400,
                          fontSize: 18,
                          color: const Color.fromARGB(163, 55, 71, 79),
                        ),
                      ),
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: deviceHeight * 0.3,
                        child: Stack(children: [
                          ClipRRect(
                            child: Image.asset('assets/images/bottomimage.png'),
                          ),
                          ClipRRect(
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                              child: SizedBox(
                                width: double.infinity,
                                height: deviceHeight * 0.4,
                              ),
                            ),
                          )
                        ])),
                  ],
                ),
              ),
            ),
          ),
        ]));
  }
}
