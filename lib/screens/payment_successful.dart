import 'package:flutter/material.dart';

import '../widgets/background_setup.dart';
import '../widgets/title_name.dart';

class PaymentSuccessful extends StatelessWidget {
  static const String routeName = '/payment-successful';
  const PaymentSuccessful({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final orderPrice = ModalRoute.of(context)!.settings.arguments as double;
   

    Widget cDivider() {
      return SizedBox(
        height: deviceHeight * 0.02,
      );
    }

    return BackgroundSetup(
        centerWidget: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const TitleName(title: 'Payment Confirmation'),
      ),
      body: Container(
        color: const Color.fromARGB(150, 255, 255, 255),
        width: double.infinity,
        height: deviceHeight * 0.9,
        child: Column(
          children: [
            Image.asset(
              'assets/images/paymentsuccessful.png',
              height: deviceHeight * 0.25,
              width: double.infinity,
            ),
            const TitleName(title: 'Payment Successful'),
            cDivider(),
            Text(
              'Total amount paid by Debit Card',
              style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: deviceWidth * 0.042,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic),
            ),
            Text(
              'Please help us with our product reviews.',
              style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: deviceWidth * 0.042,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22), //
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: deviceHeight * 0.05,
                    width: deviceWidth * 0.6,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.amber[200],
                        borderRadius: BorderRadius.circular(25)),
                    child: const Text(
                      'Order# 5343942394',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  cDivider(),
                  Container(
                    height: deviceHeight * 0.2,
                    width: deviceWidth * 0.9,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 248, 229, 177),
                        borderRadius: BorderRadius.circular(18)),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: deviceHeight * 0.005),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Subtotal',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text('Rs : ${orderPrice.round()}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500))
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: deviceHeight * 0.005),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Delivery Charges',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text('Rs : 100',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500))
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
                                const Text(
                                  'Total',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text('Rs : ${orderPrice.round() + 100}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500))
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
                            const Text('Debit card'),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
