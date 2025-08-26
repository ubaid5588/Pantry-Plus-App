import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleName extends StatelessWidget {
  final String title;
  const TitleName({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: GoogleFonts.getFont(
          'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 22,
        ));
  }
}
