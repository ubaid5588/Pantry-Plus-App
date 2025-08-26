import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_data_provider.dart';

class BagItem extends StatelessWidget {
  final String id;
  final String title;
  final int price;
  final String weight;
  final int quantity;
  final String image;
  const BagItem(
      {super.key,
      required this.id,
      required this.title,
      required this.price,
      required this.weight,
      required this.quantity,
      required this.image});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return InkWell(
      child: Container(
        margin: EdgeInsets.all(deviceHeight * 0.002),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color.fromARGB(230, 255, 255, 255)),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  height: deviceHeight * 0.12,
                  width: deviceWidth * 0.25,
                  padding: EdgeInsets.all(deviceWidth * 0.012),
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(120, 230, 230, 230),
                      borderRadius: BorderRadius.circular(6)),
                  child: ClipRRect(
                    // borderRadius: BorderRadius.circular(15),
                    child: Image.network(
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
              width: deviceWidth * 0.044,
            ),
            SizedBox(
              height: deviceHeight * 0.1,
              width: deviceWidth * 0.55,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(fontSize: 18),
                      ),
                      Text(
                        weight,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: deviceHeight * 0.005,
                  ),
                  Text(
                    'Rs ${((price * 1.2).toInt()).toString()}',
                    style: const TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rs ${price.toString()}',
                        style: TextStyle(
                            color: Colors.green[700],
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      Consumer<UserDataProvider>(
                          builder: (_, data, child) => Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (quantity > 0) {
                                        data.chQuantityProduct(
                                            id, quantity - 1);
                                      }
                                    },
                                    child: Container(
                                      // alignment: Alignment.center,
                                      width: deviceWidth * 0.08,
                                      height: deviceHeight * 0.032,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: Colors.red),
                                      child: const Center(
                                        child: Text(
                                          '-',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: deviceWidth * 0.04),
                                    child: Text(quantity.toString()),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (quantity < 5) {
                                        data.chQuantityProduct(
                                            id, quantity + 1);
                                      }
                                    },
                                    child: Container(
                                      width: deviceWidth * 0.08,
                                      height: deviceHeight * 0.032,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: Colors.green),
                                      child: const Center(
                                        child: Text(
                                          '+',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ))
                    ],
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
