import 'package:flutter/material.dart';

import '../widgets/background_setup.dart';
import '../widgets/title_name.dart';
import 'active_orders_screen.dart';

import './past_orders_screen.dart';

class MyOrders extends StatelessWidget {
  static const routeName = '/my-orders';
  const MyOrders({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;

    final List<Widget> tabs = [
      const ActiveOrdersScreen(),
      const PastOrdersScreen(),
    ];

    return BackgroundSetup(
      centerWidget: DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const TitleName(title: 'My Orders'),
            backgroundColor: Colors.transparent,
            bottom: const TabBar(
              indicatorColor: Color.fromARGB(255, 33, 68, 243),
              labelColor: Color.fromARGB(255, 33, 68, 243),
              unselectedLabelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(icon: Icon(Icons.local_shipping), text: 'Active Orders'),
                Tab(
                    icon: Icon(Icons.assignment_turned_in),
                    text: 'Past Orders'),
              ],
            ),
          ),
          body: SingleChildScrollView(
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: double.infinity,
                height: deviceHeight * 0.95,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(12)),
                child: TabBarView(
                  children: tabs,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
