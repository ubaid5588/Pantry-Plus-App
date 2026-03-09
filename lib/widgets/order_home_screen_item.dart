import 'package:flutter/material.dart';

class OrderHomeScreenItem extends StatelessWidget {
  final String name;
  final String image;
  final int price;
  final int quantity;
  final DateTime date;
  const OrderHomeScreenItem(
      {super.key,
      required this.name,
      required this.image,
      required this.price,
      required this.quantity,
      required this.date});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(deviceHeight * 0.001),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6), color: Colors.white),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  height: deviceHeight * 0.12,
                  width: deviceWidth * 0.25,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(120, 230, 230, 230),
                      borderRadius: BorderRadius.circular(6)),
                  child: ClipRRect(
                    // borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      image,
                      fit: BoxFit.contain,
                      width: deviceWidth * 0.40,
                      height: deviceHeight * 0.14,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: deviceWidth * 0.045,
            ),
            SizedBox(
              height: deviceHeight * 0.1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    name,
                    style: const TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.002,
                  ),
                  Text(
                    'Rs ${((price * 1.2).toInt()).toString()}',
                    style: const TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Text(
                    'Rs ${price.toString()}',
                    style: TextStyle(
                        color: Colors.green[700],
                        fontSize: 15,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
