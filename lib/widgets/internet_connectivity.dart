import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../widgets/title_name.dart';

class InternetConnectivity extends StatelessWidget {
  final Widget Function(BuildContext context) futureBuilder;
  const InternetConnectivity({super.key, required this.futureBuilder});

  Future<bool> _checkConnection() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (!connectivityResult.contains(ConnectivityResult.mobile) &&
        !connectivityResult.contains(ConnectivityResult.wifi)) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return FutureBuilder<bool>(
        future: _checkConnection(), // Pass the future here
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator(); // Show loading indicator while checking the connection
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData && snapshot.data == false) {
            return Container(
              padding: EdgeInsets.only(top: deviceHeight * 0.16),
              child: Center(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/nointernetconnection.png',
                      width: deviceWidth * 0.8,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
                      child: const FittedBox(
                          child: TitleName(
                              title: "check your internet connection!")),
                    ),
                  ],
                ),
              ),
            ); // Handle no connection
          } else {
            return futureBuilder(context);
          }
        });
  }
}
