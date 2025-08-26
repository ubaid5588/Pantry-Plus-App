import 'package:flutter/material.dart';
import 'dart:ui';

class BackgroundSetup extends StatelessWidget {
  final Widget centerWidget;
  const BackgroundSetup({super.key, required this.centerWidget});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    return Container(
      height: deviceHeight,
      color: const Color.fromARGB(250, 242, 242, 242),
      child: Stack(
        children: [
          ClipPath(
            clipper: CustomClipPath(),
            child: SizedBox(
                height: deviceHeight * 0.40,
                width: double.infinity,
                child: Image.asset(
                  'assets/images/backimage02.png',
                  fit: BoxFit.cover,
                )),
          ),
          ClipRRect(
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                child: SizedBox(
                  width: double.infinity,
                  height: deviceHeight * 0.99,
                )),
          ),
          SizedBox(height: deviceHeight, child: centerWidget),
        ],
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    final lowpoint = size.height - 30;
    final highpoint = size.height - 60;

    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 4, highpoint, size.width / 2, lowpoint);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, lowpoint);

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
