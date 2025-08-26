import 'package:flutter/material.dart';

class EditProduct extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  const EditProduct(
      {super.key,
      required this.image,
      required this.title,
      required this.subtitle,
      required this.onEdit,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      child: Card(
        margin: EdgeInsets.symmetric(
            horizontal: deviceWidth * 0.014, vertical: deviceHeight * 0.002),
        color: const Color.fromARGB(150, 255, 255, 255),
        elevation: 2,
        child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.white,
              radius: deviceWidth * 0.08,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(deviceWidth * 0.1),
                child: Image.network(
                  fit: BoxFit.cover,
                  image,
                ),
              ),
            ),
            title: Text(
              title,
              style: TextStyle(
                  fontSize: deviceWidth * 0.048, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              subtitle,
              style: TextStyle(
                  fontSize: deviceWidth * 0.044, fontWeight: FontWeight.w500),
            ),
            trailing: SizedBox(
              height: 50,
              width: 96,
              child: Row(
                children: [
                  IconButton(onPressed: onEdit, icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: onDelete,
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ))
                ],
              ),
            )),
      ),
    );
  }
}
