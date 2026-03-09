import 'package:flutter/material.dart';

import '../widgets/user_info.dart';
import '../providers/auth_services.dart';
import '../widgets/list_title_style1.dart';
import '../widgets/title_name.dart';
// import '../screens/add_address.dart';

class AdminAccountScreen extends StatefulWidget {
  // convert to statelesswidget
  const AdminAccountScreen({super.key});

  @override
  State<AdminAccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AdminAccountScreen> {
  final auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

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
            padding: EdgeInsets.only(left: 14, top: 12, bottom: 8),
            child: TitleName(title: 'Account Screen ')),
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
              // GestureDetector(
              //   onTap: () {
              //     Navigator.of(context).pushNamed(MyAddress.routeName);
              //   },
              //   child: const ListTitleStyle1(
              //     title: 'My Address',
              //     iconName: Icons.location_on_rounded,
              //   ),
              // ),

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
