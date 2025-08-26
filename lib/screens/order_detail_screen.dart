import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/background_setup.dart';
import '../widgets/order_all_product.dart';
import '../widgets/title_name.dart';
import '../providers/user_data_provider.dart';
import './show_all_orders.dart';

class OrderDetailScreen extends StatefulWidget {
  static const String routeName = '/order-detail-screen';
  const OrderDetailScreen({super.key});

  @override
  State<OrderDetailScreen> createState() => _OrderDetailScreenState();
}

class _OrderDetailScreenState extends State<OrderDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final orderDetialData = ModalRoute.of(context)!.settings.arguments as Map;
    final orderId = orderDetialData['id'];
    final checkDelievery = orderDetialData['checkDelivery'] as String;
    final orderData = Provider.of<UserDataProvider>(context, listen: false);
    final orderDetails = orderData.isAdmin
        ? orderData.findOrderByIdAdmin(orderId.toString())
        : orderData.findOrderById(orderId.toString());

    final List<Map> orders = orderDetails['orderProducts'];

    Future<void> updateDeliveryStatus(
        String orderIdToUpdate, String orderId) async {
      try {
        // Reference to the 'orders' collection
        CollectionReference ordersCollection =
            FirebaseFirestore.instance.collection('orders');

        // Get the document with the 'orders' array field
        DocumentSnapshot ordersDoc = await ordersCollection.doc('orders').get();

        if (ordersDoc.exists) {
          List<dynamic> ordersList = ordersDoc['orders'];

          // Find the order with the matching orderId
          for (var order in ordersList) {
            if (order['orderId'] == orderIdToUpdate && order['id'] == orderId) {
              // Update deliveryUpdate to true
              order['deliveryUpdate'] = true;
              break;
            }
          }

          // Update the document in Firestore
          await ordersCollection.doc('orders').update({'orders': ordersList});
        } else {}
      } catch (_) {}
    }

    Future<void> updateUserOrderDeliveryStatus(
        String userId, String orderId) async {
      try {
        // Reference to the user's document in the 'users' collection
        DocumentReference userDocRef =
            FirebaseFirestore.instance.collection('users').doc(userId);

        // Fetch the user's document
        DocumentSnapshot userDoc = await userDocRef.get();

        if (userDoc.exists) {
          List<dynamic> ordersList = userDoc['orders'];

          // Find the specific order by orderId
          for (var order in ordersList) {
            if (order['id'] == orderId) {
              // Update deliveryUpdate to true
              order['deliveryUpdate'] = true;
              break;
            }
          }

          // Write the updated orders array back to Firestore
          await userDocRef.update({'orders': ordersList});
        } else {}
      } catch (_) {}
    }

    Widget cDivider() {
      return SizedBox(
        height: deviceHeight * 0.02,
      );
    }

    Widget text1(String text) {
      return Text(
        text,
        style: TextStyle(
            fontSize: deviceHeight * 0.019, fontWeight: FontWeight.w500),
      );
    }

    return BackgroundSetup(
        centerWidget: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const TitleName(title: 'Order Detail Screen'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .pushNamed(ShowAllOrders.routeName, arguments: {
                'orders': orders,
                'checkdelievery': checkDelievery
              }),
              child: OrderAllProduct(
                orderProducts: orderDetails['orderProducts'],
                totalPrice: orderDetails['totalPrice'],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: deviceHeight * 0.05,
                    width: deviceWidth * 0.8,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.amber[200],
                        borderRadius: BorderRadius.circular(25)),
                    child: Text(
                      'Order Id#  ${orderDetails['id']}',
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ),
                  cDivider(),
                  SizedBox(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Order Date: ',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[700]),
                        ),
                        Text(
                          DateFormat('d, MMMM  hh:mm a')
                              .format(orderDetails['id']),
                          style: TextStyle(
                              fontSize: deviceWidth * 0.046,
                              color: Colors.grey[800]), //
                        ),
                      ],
                    ),
                  ),
                  cDivider(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              const Icon(
                                Icons.pedal_bike_outlined,
                                color: Colors.green,
                              ),
                              Column(
                                children: [
                                  Text(
                                    '.\n.\n.\n.',
                                    style: TextStyle(
                                        fontWeight: FontWeight.values[8],
                                        color: orderDetails['deliveryUpdate'] ==
                                                true
                                            ? Colors.green
                                            : Colors.black),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: deviceWidth * 0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order from',
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: deviceWidth * 0.77,
                                  child: const Text(
                                    'College road pantry plus mart Mardan',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: orderDetails['deliveryUpdate'] == true
                                ? Colors.green
                                : Colors.black,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: deviceWidth * 0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Delivery address',
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: deviceWidth * 0.77,
                                  child: Text(
                                    orderDetails['userAddress']['homeAddress'],
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  cDivider(),
                  Container(
                    height: deviceHeight * (orders.length * 0.036) +
                        deviceHeight * 0.024 +
                        deviceHeight * 0.062 +
                        2 +
                        50,
                    width: deviceWidth * 0.9,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 248, 229, 177),
                        borderRadius: BorderRadius.circular(15)),
                    child: Container(
                      padding: EdgeInsets.all(deviceHeight * 0.024),
                      child: Column(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: deviceHeight * (orders.length * 0.037),
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        text1(
                                          orders[index]['name'],
                                        ),
                                        Row(
                                          children: [
                                            text1(
                                                '${orders[index]['quantity'].toString()}x'),
                                            SizedBox(
                                              width: deviceWidth * 0.03,
                                            ),
                                            text1(
                                                'Rs : ${orders[index]['price'].toString()}'),
                                          ],
                                        )
                                      ],
                                    );
                                  },
                                  itemCount: orders.length,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: deviceHeight * 0.005),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                text1(
                                  'Delivery Charges',
                                ),
                                text1(
                                  'Rs : 100',
                                )
                              ],
                            ),
                          ),
                          const Divider(
                            color: Color.fromARGB(100, 177, 66, 66),
                            thickness: 1,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: deviceHeight * 0.005),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                text1(
                                  'Total',
                                ),
                                text1(
                                  'Rs : ${orderDetails['totalPrice']}',
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  cDivider(),
                  Container(
                    alignment: Alignment.center,
                    height: deviceHeight * 0.07,
                    width: deviceWidth * 0.9,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(168, 97, 240, 233),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'Paid with',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.credit_card),
                            SizedBox(
                              width: deviceWidth * 0.015,
                            ),
                            const Text('Cash on delievery'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            orderData.isAdmin && orderDetails['deliveryUpdate'] == false
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () async {
                        await updateDeliveryStatus(orderDetails['orderId'],
                            orderDetails['id'].toString());
                        await updateUserOrderDeliveryStatus(
                            orderDetails['orderId'],
                            orderDetails['id'].toString());
                        // print(
                        //   orderDetails['orderId'],
                        // );
                        // print(orderDetails['id'].toString());
                        if (context.mounted) Navigator.of(context).pop();
                      },
                      child: Container(
                        width: deviceWidth * 0.8,
                        height: deviceHeight * 0.048,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(206, 47, 245, 54),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                width: 1,
                                color: const Color.fromARGB(255, 84, 185, 87))),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child: Text(
                              'Order delivered',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
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
                : const Text('')
          ],
        ),
      ),
    ));
  }
}
