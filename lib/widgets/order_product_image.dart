import 'package:flutter/material.dart';

class OrderProductImage extends StatelessWidget {
  final Widget image;

  final BorderRadius bRadius;
  final BorderRadius iRadius;
  const OrderProductImage(
      {super.key,
      required this.image,
      required this.bRadius,
      required this.iRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(150, 230, 230, 230),
          borderRadius: bRadius),
      child: ClipRRect(borderRadius: iRadius, child: image),
    );
  }
}
