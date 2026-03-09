import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../providers/user_data_provider.dart';
import '../widgets/background_setup.dart';
import './home_screen.dart';
import './categories_screen.dart';
import 'my_bag_screen.dart';
import './account_screen.dart';
import '../admin/edit_product_screen.dart';
import '../admin/admin_account_screen.dart';
import '../admin/client_orders.dart';

class WholeScreen extends StatefulWidget {
  static const String routeName = '/WholeScreen';
  const WholeScreen({
    super.key,
  });

  @override
  State<WholeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<WholeScreen> {
  int selectedTab = 0;

  // final isAdmin = false;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final checkAdmin = Provider.of<UserDataProvider>(context, listen: true);

    List pages = checkAdmin.isAdmin
        ? const [
            HomeScreen(),
            // Center(
            //   child:
            EditProductScreen(),
            // ),
            ClientOrders(),
            Center(
              child: AdminAccountScreen(),
            ),
          ]
        : const [
            Center(child: HomeScreen()),
            Center(
              child: CategoriesScreen(),
            ),
            Center(
              child: MyBagScreen(),
            ),
            Center(
              child: AccountScreen(),
            ),
          ];

    changeTab(int index) {
      setState(() {
        selectedTab = index;
      });
    }

    return Scaffold(
      body: BackgroundSetup(
          centerWidget: Container(
              padding: const EdgeInsets.only(
                top: 40,
              ),
              child: pages[selectedTab])),
      bottomNavigationBar: GNav(
        selectedIndex: selectedTab,
        onTabChange: (index) {
          changeTab(index);
        },

        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        tabBackgroundGradient: const LinearGradient(colors: [
          Color.fromARGB(255, 244, 97, 87),
          Color.fromARGB(255, 104, 248, 109)
        ], begin: Alignment.bottomRight, end: Alignment.topLeft),

        hoverColor: const Color.fromARGB(255, 210, 210, 210), //
        haptic: true,
        tabBorderRadius: 25,
        backgroundColor: Colors.white,
        tabMargin: const EdgeInsets.symmetric(vertical: 10, horizontal: 1),

        tabShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 1)
        ], // tab button shadow
        curve: Curves.easeOutExpo, // tab animation curves
        duration: const Duration(milliseconds: 100), // tab animation duration
        gap: 0, // the tab button gap between icon and text
        color: Colors.grey[800], // unselected icon color
        activeColor: Colors.white, // selected icon and text color
        iconSize: 24, // tab button icon size
        tabBackgroundColor:
            Colors.purple.withOpacity(0.1), // selected tab background color
        padding: EdgeInsets.symmetric(
            horizontal: deviceWidth * 0.04,
            vertical: deviceHeight * 0.015), // navigation bar padding

        tabs: checkAdmin.isAdmin
            ? const [
                GButton(
                  icon: Icons.home,
                  text: 'Your Products',
                ),
                GButton(icon: Icons.edit_document, text: "Edit Products"),
                GButton(icon: Icons.shopping_basket, text: "Client Orders"),
                GButton(icon: Icons.menu, text: "Account"),
              ]
            : const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(icon: Icons.grid_on, text: "Categories"),
                GButton(icon: Icons.shopping_basket, text: "My Bag"),
                GButton(icon: Icons.menu, text: "Account"),
              ],
      ),
    );
  }
}
