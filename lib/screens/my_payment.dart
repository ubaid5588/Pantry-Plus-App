import 'package:flutter/material.dart';
// import 'package:flutter_app/screens/add_debit_card.dart';
// import 'package:provider/provider.dart';

import '../widgets/background_setup.dart';
import '../widgets/title_name.dart';
// import '../providers/user_data_provider.dart';

class Payment extends StatefulWidget {
  static const routeName = '/payment';
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    // final deviceHeight = MediaQuery.of(context).size.height;
    // final deviceWidth = MediaQuery.of(context).size.width;
    // final credentionalData =
    //     Provider.of<UserDataProvider>(context, listen: true);

    // void userConfirm() {
    //   showDialog(
    //       context: context,
    //       builder: (context) => AlertDialog(
    //             title: const Text('Delete Address'),
    //             content:
    //                 const Text('Are you sure you want to delete this address?'),
    //             actions: [
    //               TextButton(
    //                   onPressed: () {
    //                     credentionalData.removeDebitCard();
    //                     Navigator.of(context).pop();
    //                   },
    //                   child: const Text('Yes')),
    //               TextButton(
    //                   onPressed: () => Navigator.of(context).pop(),
    //                   child: const Text('No'))
    //             ],
    //           ));
    // }

    return BackgroundSetup(
        centerWidget: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              title: const TitleName(title: 'Payment'),
              backgroundColor: Colors.transparent,
            ),
            body: Container(
                color: Colors.white60,
                alignment: Alignment.topCenter,
                child: const Column(
                  children: [
                    TitleName(title: 'Only On'),
                    TitleName(title: 'Cash On Delievery')
                  ],
                )
                // Container(
                //   padding: const EdgeInsets.all(12),
                //   decoration: BoxDecoration(
                //       color: credentionalData.credentional.isEmpty
                //           ? const Color.fromARGB(150, 80, 80, 80)
                //           : const Color.fromARGB(25, 230, 230, 230),
                //       borderRadius: BorderRadius.circular(15)),
                //   child: credentionalData.credentional.isEmpty
                //       ? GestureDetector(
                //           onTap: () => Navigator.of(context)
                //               .pushNamed(AddDebitCard.routeName),
                //           child: Container(
                //             height: deviceHeight * 0.25,
                //             width: deviceWidth * 0.9,
                //             alignment: Alignment.center,
                //             child: const Column(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: [
                //                 Text('+',
                //                     style: TextStyle(
                //                         color:
                //                             Color.fromARGB(220, 255, 255, 255),
                //                         fontWeight: FontWeight.w200,
                //                         fontSize: 36)),
                //                 Text(
                //                   'Add your debit card',
                //                   style: TextStyle(
                //                       // color: Color.fromARGB(200, 255, 255, 255),
                //                       color: Color.fromARGB(220, 255, 255, 255),
                //                       fontWeight: FontWeight.w500,
                //                       fontSize: 17),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         )
                //       : Stack(
                //           children: [
                //             Container(
                //               width: double.infinity,
                //               height: deviceHeight * 0.27,
                //               decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(15),
                //                 gradient: const LinearGradient(
                //                   colors: [
                //                     Color.fromARGB(175, 248, 3, 3),
                //                     Color.fromARGB(175, 11, 7, 244)
                //                   ],
                //                   begin: Alignment.topLeft,
                //                   end: Alignment.bottomRight,
                //                 ),
                //                 boxShadow: const [
                //                   BoxShadow(
                //                     color: Colors.black26,
                //                     blurRadius: 10,
                //                     offset: Offset(0, 5),
                //                   ),
                //                 ],
                //               ),
                //               child: const Padding(
                //                 padding: EdgeInsets.all(24.0),
                //                 child: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   mainAxisAlignment:
                //                       MainAxisAlignment.spaceBetween,
                //                   children: <Widget>[
                //                     Text(
                //                       '1343 8433 8453 8545',
                //                       style: TextStyle(
                //                         color: Colors.white,
                //                         fontSize: 23,
                //                         fontWeight: FontWeight.bold,
                //                         letterSpacing: 2.0,
                //                       ),
                //                     ),
                //                     SizedBox(height: 10),
                //                     Text(
                //                       'Card Holder',
                //                       style: TextStyle(
                //                         color: Colors.white70,
                //                         fontSize: 12,
                //                       ),
                //                     ),
                //                     Text(
                //                       'Muhammad Ubaid',
                //                       style: TextStyle(
                //                         color: Colors.white,
                //                         fontSize: 18,
                //                         fontWeight: FontWeight.bold,
                //                       ),
                //                     ),
                //                     Row(
                //                       mainAxisAlignment:
                //                           MainAxisAlignment.spaceBetween,
                //                       children: <Widget>[
                //                         Text(
                //                           'Expiry Date',
                //                           style: TextStyle(
                //                             color: Colors.white70,
                //                             fontSize: 12,
                //                           ),
                //                         ),
                //                         Text(
                //                           '12/24',
                //                           style: TextStyle(
                //                             color: Colors.white,
                //                             fontSize: 18,
                //                             fontWeight: FontWeight.bold,
                //                           ),
                //                         ),
                //                       ],
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //             Container(
                //               decoration: const BoxDecoration(
                //                   color: Color.fromARGB(50, 255, 255, 255),
                //                   borderRadius: BorderRadius.only(
                //                       topLeft: Radius.circular(15),
                //                       topRight: Radius.circular(15))),
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.end,
                //                 children: [
                //                   IconButton(
                //                       onPressed: userConfirm,
                //                       icon: Icon(
                //                         Icons.delete,
                //                         color: const Color.fromARGB(
                //                             205, 19, 242, 34),
                //                         size: deviceWidth * 0.075,
                //                       )),
                //                 ],
                //               ),
                //             )
                //           ],
                //         ),

                // )
                )));
  }
}
