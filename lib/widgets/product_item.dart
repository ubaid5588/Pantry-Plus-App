import 'package:flutter/material.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';

class ProductItem extends StatelessWidget {
  final String title;
  final int price;
  final String image;
  final double rating;
  const ProductItem(
      {super.key,
      required this.title,
      required this.price,
      required this.image,
      required this.rating});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(deviceHeight * 0.0028),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6), color: Colors.white),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                height: deviceHeight * 0.147,
                width: deviceWidth * 0.44,
                padding: EdgeInsets.all(deviceWidth * 0.025),
                decoration: BoxDecoration(
                    color: const Color.fromARGB(120, 230, 230, 230),
                    borderRadius: BorderRadius.circular(6)),
                child: ClipRRect(
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                    width: deviceWidth * 0.40,
                    height: deviceHeight * 0.16,
                  ),
                ),
              ),
            ],
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: deviceHeight * 0.007,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Rs ${((price * 1.2).toInt()).toString()}',
                style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: deviceWidth * 0.02,
              ),
              Text(
                'Rs ${price.toString()}',
                style: TextStyle(
                    color: Colors.green[700],
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(
            height: deviceHeight * 0.005,
          ),
          rating > 0
              ? RatingBar.readOnly(
                  initialRating: rating,
                  alignment: Alignment.center,
                  filledIcon: Icons.star,
                  emptyIcon: Icons.star_border,
                  size: deviceHeight * 0.02,
                )
              : const Text('')
        ],
      ),
    );
  }
}
