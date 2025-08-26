import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final String image;
  const CategoryItem({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(deviceWidth * 0.008),
      padding: EdgeInsets.only(bottom: deviceHeight * 0.03),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(deviceWidth * 0.04),
          color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(deviceWidth * 0.04),
                    topRight: Radius.circular(deviceWidth * 0.04)),
                child: Image.asset(
                  image,
                  fit: BoxFit.fill,
                  height: deviceHeight * 0.163,
                ),
              ),
            ],
          ),
          const Divider(),
          Text(
            title,
            style: TextStyle(fontSize: deviceWidth * 0.045),
          )
        ],
      ),
    );
  }
}
