import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './order_product_image.dart';

class OrderAllProduct extends StatelessWidget {
  final List<Map> orderProducts;
  final int totalPrice;

  const OrderAllProduct({
    super.key,
    required this.orderProducts,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    final List<String> productsName =
        orderProducts.map((person) => person['name'].toString()).toList();

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
          decoration: const BoxDecoration(
            color: Color.fromARGB(200, 255, 255, 255),
          ),
          height: deviceHeight * 0.148,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (orderProducts.isNotEmpty && orderProducts.length < 2)
                      OrderProductImage(
                        image: Image.network(
                          orderProducts[0]['image'],
                          height: deviceHeight * 0.122,
                          width: deviceWidth * 0.28,
                        ),
                        bRadius: BorderRadius.circular(deviceWidth * 0.03),
                        iRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(deviceWidth * 0.00)),
                      ),
                    if (orderProducts.length > 1 && orderProducts.length < 3)
                      OrderProductImage(
                        image: Row(
                          children: [
                            Image.network(
                              orderProducts[0]['image'],
                              height: deviceHeight * 0.122,
                              width: deviceWidth * 0.14,
                            ),
                            customDivider(),
                            Image.network(
                              orderProducts[1]['image'],
                              height: deviceHeight * 0.06,
                              width: deviceWidth * 0.14,
                            ),
                          ],
                        ),
                        bRadius: BorderRadius.circular(deviceWidth * 0.03),
                        iRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(deviceWidth * 0.00)),
                      ),
                    if (orderProducts.length > 2 && orderProducts.length < 4)
                      OrderProductImage(
                        image: Column(
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  orderProducts[0]['image'],
                                  height: deviceHeight * 0.06,
                                  width: deviceWidth * 0.14,
                                ),
                                customDivider(),
                                Image.network(
                                  orderProducts[1]['image'],
                                  height: deviceHeight * 0.06,
                                  width: deviceWidth * 0.14,
                                ),
                              ],
                            ),
                            customDivider2(),
                            Image.network(
                              orderProducts[2]['image'],
                              height: deviceHeight * 0.06,
                              width: deviceWidth * 0.14,
                            ),
                          ],
                        ),
                        bRadius: BorderRadius.circular(deviceWidth * 0.03),
                        iRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(deviceWidth * 0.00)),
                      ),
                    if (orderProducts.length > 3)
                      OrderProductImage(
                        image: Column(
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  orderProducts[0]['image'],
                                  height: deviceHeight * 0.06,
                                  width: deviceWidth * 0.14,
                                ),
                                customDivider(),
                                Image.network(
                                  orderProducts[1]['image'],
                                  height: deviceHeight * 0.06,
                                  width: deviceWidth * 0.14,
                                ),
                              ],
                            ),
                            customDivider2(),
                            Row(
                              children: [
                                Image.network(
                                  orderProducts[2]['image'],
                                  height: deviceHeight * 0.06,
                                  width: deviceWidth * 0.14,
                                ),
                                customDivider(),
                                orderProducts.length < 5
                                    ? Image.network(
                                        orderProducts[3]['image'],
                                        height: deviceHeight * 0.06,
                                        width: deviceWidth * 0.14,
                                      )
                                    : Stack(
                                        children: [
                                          Image.network(
                                            orderProducts[3]['image'],
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
                                              '${(orderProducts.length - 4).toString()}+',
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
                                productsName.join(', '),
                                maxLines: 3,
                                style: GoogleFonts.getFont('Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: deviceWidth * 0.042,
                                    textStyle: const TextStyle(
                                      wordSpacing: 2,
                                    ))),
                          ),
                          SizedBox(
                            height: deviceHeight * 0.01,
                          ),
                          Text(
                            'Rs $totalPrice',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.green[700],
                              fontSize: deviceHeight * 0.019,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
