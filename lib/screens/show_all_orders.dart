import 'package:flutter/material.dart';

import '../widgets/background_setup.dart';
import '../widgets/title_name.dart';
import '../widgets/all_order_product_item.dart';

class ShowAllOrders extends StatelessWidget {
  static const routeName = '/show-all-orders';
  const ShowAllOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final Map orderDetails = ModalRoute.of(context)!.settings.arguments as Map;

    final orderProducts = orderDetails['orders'];

    return BackgroundSetup(
        centerWidget: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: const TitleName(title: 'All Order Products'),
            ),
            backgroundColor: Colors.transparent,
            body: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(180, 255, 255, 255)),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return AllOrderProductItem(
                        id: orderProducts[index]['id'],
                        title: orderProducts[index]['name'],
                        price: orderProducts[index]['price'],
                        image: orderProducts[index]['image'],
                        checkDelievery: orderDetails['checkdelievery'],
                      );
                    },
                    itemCount: orderProducts.length,
                  )),
            )));
  }
}
