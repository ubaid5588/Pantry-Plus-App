import 'package:flutter/material.dart';

class ListTitleStyle1 extends StatelessWidget {
  final IconData iconName;
  final String title;
  final Color iconColor;
  final Color textColor;
  const ListTitleStyle1({
    super.key,
    required this.title,
    required this.iconName,
    this.iconColor = Colors.black,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration:
          const BoxDecoration(color: Color.fromARGB(200, 230, 230, 230)),
      child: ListTile(
        leading: Icon(
          iconName,
          color: iconColor,
        ),
        title: Text(
          title,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }
}
