import 'package:flutter/material.dart';

import '../providers/auth_services.dart';
import '../widgets/title_name.dart';
import '../screens/past_orders_screen.dart';
import '../screens/active_orders_screen.dart';

class ClientOrders extends StatefulWidget {
  const ClientOrders({super.key});

  @override
  State<ClientOrders> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<ClientOrders> {
  final auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    // final deviceWidth = MediaQuery.of(context).size.width;

    // Widget custoDivider() {
    //   return Divider(
    //     height: deviceHeight * 0.002,
    //     thickness: deviceHeight * 0.003,
    //   );
    // }

    final List<Widget> tabs = [
      // Text('Active Orders'),
      // Text('Delivered Orders')
      const ActiveOrdersScreen(), // make widget for both
      const PastOrdersScreen(),
    ];

    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: deviceHeight * 0.02,
          title: const TitleName(title: 'Client Orders'),
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
                  text: 'Delivered Orders'),
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
    );
  }
}
