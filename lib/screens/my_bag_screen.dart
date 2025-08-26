import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/title_name.dart';
import '../widgets/bag_item.dart';
import '../providers/user_data_provider.dart';
import './whole_screen.dart';
import 'my_payment.dart';
import 'my_address.dart';
import './payment_successful.dart';
import '../widgets/internet_connectivity.dart';

class MyBagScreen extends StatelessWidget {
  const MyBagScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final showItem = Provider.of<UserDataProvider>(context);

    var subtotal = 0.0;
    var delivey = 100;

    for (var product in showItem.myBag) {
      subtotal = subtotal + product['price'] * product['quantity'];
    }

    var total = subtotal + delivey;

    final deliveryDate = DateTime.now().add(const Duration(days: 2));

    Widget customDivider() {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.03),
        child: const Divider(),
      );
    }

    void orderProducts() {
      if (showItem.userAdress.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Please add your address',
            textAlign: TextAlign.center,
          ),
          duration: Duration(milliseconds: 1400),
        ));
      } else if (showItem.credentional.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Please add your debit card',
            textAlign: TextAlign.center,
          ),
          duration: Duration(milliseconds: 1400),
        ));
      } else {
        showItem.placeOrder(total.toInt());
        Navigator.of(context)
            .pushNamed(PaymentSuccessful.routeName, arguments: subtotal);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.only(left: 14, top: 9, bottom: 9),
            child: TitleName(title: 'My Bag')),
        Container(
            padding: EdgeInsets.symmetric(
                horizontal: deviceWidth * 0.015,
                vertical: deviceHeight * 0.007),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: const Color.fromARGB(148, 255, 255, 255),
            ),
            height: deviceHeight * 0.80,
            width: deviceWidth * 0.96,
            child: InternetConnectivity(
              futureBuilder: (context) {
                return FutureBuilder(
                    future: showItem.getProductToBag(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return SizedBox(
                          height: deviceHeight * 0.8,
                          child: Column(
                            children: [
                              Expanded(
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: ListView.builder(
                                    itemCount: 4,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 80,
                                              height: 80,
                                              color: Colors.grey[300],
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    height: 20,
                                                    color: Colors.grey[300],
                                                  ),
                                                  const SizedBox(height: 5),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        height: 20,
                                                        width: 50,
                                                        color: Colors.grey[300],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: 30,
                                                            width: 30,
                                                            color:
                                                                Colors.red[300],
                                                          ),
                                                          const SizedBox(
                                                              width: 5),
                                                          Container(
                                                            height: 20,
                                                            width: 20,
                                                            color: Colors
                                                                .grey[300],
                                                          ),
                                                          const SizedBox(
                                                              width: 5),
                                                          Container(
                                                            height: 30,
                                                            width: 30,
                                                            color: Colors
                                                                .green[300],
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Subtotal
                                      Container(
                                        height: 20,
                                        width: double.infinity,
                                        color: Colors.grey[300],
                                      ),
                                      const SizedBox(height: 10),
                                      // Delivery Charges
                                      Container(
                                        height: 20,
                                        width: double.infinity,
                                        color: Colors.grey[300],
                                      ),
                                      const SizedBox(height: 10),
                                      // Total
                                      Container(
                                        height: 20,
                                        width: double.infinity,
                                        color: Colors.grey[300],
                                      ),
                                      const SizedBox(height: 20),

                                      Row(
                                        children: [
                                          Icon(Icons.delivery_dining,
                                              color: Colors.grey[300],
                                              size: 40),
                                          const SizedBox(width: 10),
                                          Container(
                                            height: 20,
                                            width: 150,
                                            color: Colors.grey[300],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      // Delivery Location
                                      Row(
                                        children: [
                                          Icon(Icons.location_pin,
                                              color: Colors.grey[300],
                                              size: 40),
                                          const SizedBox(width: 10),
                                          Container(
                                            height: 20,
                                            width: 200,
                                            color: Colors.grey[300],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: double.infinity,
                                  height: 50,
                                  color: Colors.green[300],
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Place Order',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Something went wrongh'),
                        );
                      }
                      if (showItem.myBag.isEmpty) {
                        showItem.getUserAddresses();

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Center(
                              child: Text('There are no items in this bag',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                  )),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacementNamed(
                                    WholeScreen.routeName);
                              },
                              child: Container(
                                margin:
                                    EdgeInsets.only(top: deviceHeight * 0.015),
                                width: deviceWidth * 0.7,
                                height: deviceHeight * 0.048,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(216, 47, 245, 54),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        width: 1,
                                        color: const Color.fromARGB(
                                            255, 84, 185, 87))),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Pick an item',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.black),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 20.0),
                                      child: Icon(Icons.shopping_bag_outlined),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        );
                      } else {
                        return Stack(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                children: [
                                  Column(
                                    children: showItem.myBag.map((item) {
                                      return BagItem(
                                          id: item['id'],
                                          title: item['name'],
                                          price: item['price'],
                                          weight: item['weight'],
                                          quantity: item['quantity'],
                                          image: item['image']);
                                    }).toList(),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.all(deviceHeight * 0.01),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: deviceHeight * 0.005),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Subtotal',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(subtotal.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500))
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: deviceHeight * 0.005),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Delivery Charges',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(delivey.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500))
                                            ],
                                          ),
                                        ),
                                        const Divider(
                                          color:
                                              Color.fromARGB(100, 177, 66, 66),
                                          thickness: 1,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: deviceHeight * 0.005),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'Total',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              Text(total.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500))
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  customDivider(),
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Expected Date & Time',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: deviceHeight * 0.006),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                          backgroundColor: Colors.blue[300],
                                          maxRadius: 22,
                                          child: Icon(
                                            Icons.motorcycle,
                                            size: deviceWidth * 0.06,
                                          )),
                                      title: Text(
                                        ('${DateFormat('EEEE,d MMMM').format(deliveryDate)}  12:00 pm')
                                            .toString(),
                                      ),
                                    ),
                                  ),
                                  customDivider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Delivery Location',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18),
                                      ),
                                      TextButton(
                                          onPressed: () => Navigator.of(context)
                                              .pushNamed(MyAddress.routeName),
                                          child: Text(
                                            showItem.userAdress.isNotEmpty
                                                ? 'Change Address'
                                                : 'Add Addresss',
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                    255, 33, 68, 243)),
                                          ))
                                    ],
                                  ),
                                  ListTile(
                                    leading: CircleAvatar(
                                        backgroundColor: Colors.blue[300],
                                        maxRadius: 22,
                                        child: Icon(
                                          Icons.location_on_outlined,
                                          size: deviceWidth * 0.06,
                                        )),
                                    title: Text(
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400),
                                      showItem.userAdress.isEmpty
                                          ? 'Please add your address'
                                          : showItem.userAdress[0]
                                              ['homeAddress'],
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                  ),
                                  customDivider(),
                                  const Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Payment Method',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.of(context)
                                        .pushNamed(Payment.routeName),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: deviceHeight * 0.015),
                                      height: deviceHeight * 0.093,
                                      width: deviceWidth * 0.9,
                                      decoration: BoxDecoration(
                                          color: Colors.green[100],
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: deviceHeight * 0.006),
                                        child: Center(
                                          child: ListTile(
                                            leading: CircleAvatar(
                                                backgroundColor:
                                                    Colors.blue[300],
                                                maxRadius: 22,
                                                child: Icon(
                                                  FontAwesomeIcons
                                                      .moneyBill1Wave,
                                                  size: deviceWidth * 0.06,
                                                )),
                                            title: Text(
                                              'Cash on Delivery',
                                              style: TextStyle(
                                                  fontSize:
                                                      deviceWidth * 0.044),
                                            ),
                                            trailing: Icon(
                                              Icons.arrow_forward_ios,
                                              size: deviceHeight * 0.025,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: deviceHeight * 0.06,
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: InkWell(
                                onTap: orderProducts,
                                child: Container(
                                  width: deviceWidth * 0.8,
                                  height: deviceHeight * 0.048,
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          206, 47, 245, 54),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                          width: 1,
                                          color: const Color.fromARGB(
                                              255, 84, 185, 87))),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                          child: Text(
                                        'Place Order',
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      )),
                                      Padding(
                                        padding: EdgeInsets.only(left: 20.0),
                                        child: Icon(Icons.arrow_forward),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      }
                    });
              },
            ))
      ],
    );
  }
}
