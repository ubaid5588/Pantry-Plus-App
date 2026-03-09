import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../widgets/order_item.dart';
import '../providers/user_data_provider.dart';
import './order_detail_screen.dart';
import '../widgets/internet_connectivity.dart';

class PastOrdersScreen extends StatelessWidget {
  const PastOrdersScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final getOrderData = Provider.of<UserDataProvider>(context);
    final orders = getOrderData.isAdmin
        ? getOrderData.userDelieveredOrders()
        : getOrderData.pastDeliveries();

    Widget shimmerEffect() {
      return Padding(
        padding: EdgeInsets.all(deviceWidth * 0.012),
        child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.white,
            child: Container(
              height: deviceHeight * 0.28,
              width: deviceWidth * 0.99,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15)),
            )),
      );
    }

    return InternetConnectivity(futureBuilder: (context) {
      return FutureBuilder(
          future: getOrderData.isAdmin
              ? getOrderData.adminUserOrders()
              : getOrderData.getOrderedProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  shimmerEffect(),
                  shimmerEffect(),
                  shimmerEffect(),
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Something went wrongh $snapshot'),
              );
            } else if (getOrderData.isAdmin
                ? getOrderData.userDelieveredOrders().isEmpty
                : getOrderData.pastDeliveries().isEmpty) {
              return Container(
                color: Colors.white.withOpacity(0.5),
                padding: EdgeInsets.only(top: deviceHeight * 0.35),
                alignment: Alignment.topCenter,
                child: const Text(
                  'No past order',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                ),
              );
            } else {
              return Column(
                children: [
                  SizedBox(
                    height: deviceHeight * 0.816,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(
                              OrderDetailScreen.routeName,
                              arguments: {
                                'id': orders[index]['id'],
                                'categoryId': orders[index]['categoryId'],
                                'checkDelivery': 'true'
                              }),
                          child: OrderItem(
                              name: orders[index]['orderProducts'],
                              orderDate: orders[index]['id'],
                              totalPrice: orders[index]['totalPrice'],
                              productImages: orders[index]['orderProducts']),
                        );
                      },
                      itemCount: orders.length,
                    ),
                  ),
                ],
              );
            }
          });
    });
  }
}
