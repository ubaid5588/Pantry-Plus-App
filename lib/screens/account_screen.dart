import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/user_info.dart';
import '../providers/auth_services.dart';
import '../widgets/list_title_style1.dart';
import '../widgets/title_name.dart';
import 'my_address.dart';
import 'my_payment.dart';
import './my_orders.dart';
import '../providers/user_data_provider.dart';
import 'contact_us.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  final auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final getOrderData = Provider.of<UserDataProvider>(context);

    Widget custoDivider() {
      return Divider(
        height: deviceHeight * 0.002,
        thickness: deviceHeight * 0.003,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
            padding: EdgeInsets.only(left: 14, top: 9, bottom: 9),
            child: TitleName(title: 'Account')),
        //
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color.fromARGB(148, 255, 255, 255),
          ),
          height: deviceHeight * 0.8,
          width: deviceWidth * 0.96,
          child: Column(
            children: [
              const Userinfo(),
              Divider(
                height: deviceHeight * 0.005,
                thickness: deviceHeight * 0.004,
                color: Colors.green,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(MyAddress.routeName);
                },
                child: const ListTitleStyle1(
                  title: 'My Address',
                  iconName: Icons.location_on_rounded,
                ),
              ),
              custoDivider(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(Payment.routeName);
                },
                child: const ListTitleStyle1(
                  title: 'Payment',
                  iconName: Icons.credit_card,
                ),
              ),
              custoDivider(),
              GestureDetector(
                onTap: () async {
                  await getOrderData.getOrderedProducts();
                  if (context.mounted) {
                    Navigator.of(context).pushNamed(MyOrders.routeName);
                  }
                },
                child: const ListTitleStyle1(
                  title: 'My Orders',
                  iconName: Icons.shopping_basket_outlined,
                ),
              ),
              custoDivider(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(ContactUs.routeName);
                },
                child: const ListTitleStyle1(
                  title: 'Contact Us',
                  iconName: Icons.mobile_friendly,
                ),
              ),
              custoDivider(),
              SizedBox(
                height: deviceHeight * 0.07,
              ),
              InkWell(
                onTap: () async {
                  await auth.signOut();
                },
                child: const ListTitleStyle1(
                  title: 'Log out',
                  iconName: Icons.logout,
                  iconColor: Colors.red,
                  textColor: Colors.red,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
