import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import './order_product_image.dart';

class OrderItem extends StatelessWidget {
  final List name;

  final DateTime orderDate;
  final int totalPrice;
  final List<Map> productImages;
  const OrderItem(
      {super.key,
      required this.name,
      required this.orderDate,
      required this.totalPrice,
      required this.productImages});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    final List<String> productsName =
        name.map((person) => person['name'].toString()).toList();

    Widget customDivider() {
      return Container(
        color: Colors.black,
        width: deviceWidth * 0.0048,
        height: deviceHeight * 0.06,
      );
    }

    Widget customDivider2() {
      return Container(
        color: Colors.black,
        width: deviceWidth * 0.28,
        height: deviceHeight * 0.0018,
      );
    }

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: (deviceWidth + deviceWidth) * 0.01,
              vertical: (deviceWidth + deviceWidth) * 0.005),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(deviceWidth * 0.02),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(120, 0, 0, 0),
                blurRadius: 10,
                offset: Offset(0, 1),
              ),
            ],
          ),
          height: deviceHeight * 0.28,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (productImages.isNotEmpty && productImages.length < 2)
                      OrderProductImage(
                        image: Image.network(
                          productImages[0]['image'],
                          height: deviceHeight * 0.122,
                          width: deviceWidth * 0.28,
                        ),
                        bRadius: BorderRadius.circular(deviceWidth * 0.03),
                        iRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(deviceWidth * 0.00)),
                      ),
                    if (productImages.length > 1 && productImages.length < 3)
                      OrderProductImage(
                        image: Row(
                          children: [
                            Image.network(
                              productImages[0]['image'],
                              height: deviceHeight * 0.122,
                              width: deviceWidth * 0.14,
                            ),
                            customDivider(),
                            Image.network(
                              productImages[1]['image'],
                              height: deviceHeight * 0.06,
                              width: deviceWidth * 0.14,
                            ),
                          ],
                        ),
                        bRadius: BorderRadius.circular(deviceWidth * 0.03),
                        iRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(deviceWidth * 0.00)),
                      ),
                    if (productImages.length > 2 && productImages.length < 4)
                      OrderProductImage(
                        image: Column(
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  productImages[0]['image'],
                                  height: deviceHeight * 0.06,
                                  width: deviceWidth * 0.14,
                                ),
                                customDivider(),
                                Image.network(
                                  productImages[1]['image'],
                                  height: deviceHeight * 0.06,
                                  width: deviceWidth * 0.14,
                                ),
                              ],
                            ),
                            customDivider2(),
                            Image.network(
                              productImages[2]['image'],
                              height: deviceHeight * 0.06,
                              width: deviceWidth * 0.14,
                            ),
                          ],
                        ),
                        bRadius: BorderRadius.circular(deviceWidth * 0.03),
                        iRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(deviceWidth * 0.00)),
                      ),
                    if (productImages.length > 3)
                      OrderProductImage(
                        image: Column(
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  productImages[0]['image'],
                                  height: deviceHeight * 0.06,
                                  width: deviceWidth * 0.14,
                                ),
                                customDivider(),
                                Image.network(
                                  productImages[1]['image'],
                                  height: deviceHeight * 0.06,
                                  width: deviceWidth * 0.14,
                                ),
                              ],
                            ),
                            customDivider2(),
                            Row(
                              children: [
                                Image.network(
                                  productImages[2]['image'],
                                  height: deviceHeight * 0.06,
                                  width: deviceWidth * 0.14,
                                ),
                                customDivider(),
                                productImages.length < 5
                                    ? Image.network(
                                        productImages[3]['image'],
                                        height: deviceHeight * 0.06,
                                        width: deviceWidth * 0.14,
                                      )
                                    : Stack(
                                        children: [
                                          Image.network(
                                            productImages[3]['image'],
                                            height: deviceHeight * 0.06,
                                            width: deviceWidth * 0.14,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    120, 0, 0, 0),
                                                borderRadius: BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(
                                                            deviceWidth *
                                                                0.03))),
                                            alignment: Alignment.center,
                                            height: deviceHeight * 0.06,
                                            width: deviceWidth * 0.14,
                                            child: Text(
                                              '${(productImages.length - 4).toString()}+',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          )
                                        ],
                                      ),
                              ],
                            )
                          ],
                        ),
                        bRadius: BorderRadius.circular(deviceWidth * 0.03),
                        iRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(deviceWidth * 0.00)),
                      ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: deviceWidth * 0.04, top: deviceHeight * 0.003),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: deviceWidth * 0.57,
                            child: Text(
                                overflow: TextOverflow.ellipsis,
                                productsName.join(', '), // here is the problem
                                maxLines: 2,
                                style: GoogleFonts.getFont('Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    textStyle: const TextStyle(
                                      wordSpacing: 2,
                                    ))),
                          ),
                          SizedBox(
                            height: deviceHeight * 0.05,
                          ),
                          Text(
                            'Rs $totalPrice',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.green[700],
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  height: deviceHeight * 0.1,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(150, 230, 230, 230),
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(10))),
                  child: Padding(
                    padding: EdgeInsets.all(deviceWidth * 0.042),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'View order details',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: deviceWidth * 0.046),
                        ),
                        Text(
                          'Order Date: ${DateFormat('d, MMMM  hh:mm a').format(orderDate)}',
                          style: const TextStyle(
                              color: Color.fromARGB(150, 20, 20, 20),
                              fontWeight: FontWeight.w500,
                              fontSize: 15),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
