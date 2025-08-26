import 'package:flutter/material.dart';
import 'package:flutter_app/screens/add_address.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../providers/user_data_provider.dart';
import '../widgets/background_setup.dart';
import '../widgets/title_name.dart';

class MyAddress extends StatelessWidget {
  static const routeName = '/MyAdress';
  const MyAddress({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final saveAddress = Provider.of<UserDataProvider>(context, listen: true);

    void userConfirm() {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Delete Address'),
                content:
                    const Text('Are you sure you want to delete this address?'),
                actions: [
                  TextButton(
                      onPressed: () {
                        saveAddress.deleteUserAddress();
                       
                        Navigator.of(context).pop();
                      },
                      child: const Text('Yes')),
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('No'))
                ],
              ));
    }

    return BackgroundSetup(
        centerWidget: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: const TitleName(title: 'My Address'),
            ),
            backgroundColor: Colors.transparent,
            body: Align(
              alignment: Alignment.topCenter,
              child: Container(

                  // decoration: BoxDecoration(
                  //     color: saveAddress.userAdress.isNotEmpty
                  //         ? Color.fromARGB(0, 33, 16, 16)
                  //         : const Color.fromARGB(150, 80, 80, 80),

                  //     ),
                  padding: EdgeInsets.all(deviceWidth * 0.02),
                  child: FutureBuilder(
                      future: saveAddress.getUserAddresses(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Column(
                            children: [
                              Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.white,
                                  child: Container(
                                    height: deviceHeight * 0.28,
                                    width: deviceWidth * 0.99,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  )),
                            ],
                          );
                        }
                        if (snapshot.hasError) {
                          return Text(
                            'something went wrongh $snapshot',
                            style: const TextStyle(color: Colors.white),
                          );
                        }
                        if (saveAddress.userAdress.isEmpty) {
                          return GestureDetector(
                            onTap: () => Navigator.of(context)
                                .pushNamed(AddAddress.routeName),
                            child: Container(
                              height: deviceHeight * 0.28,
                              width: deviceWidth * 0.95,
                              alignment: Alignment.topCenter,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(150, 80, 80, 80),
                                  borderRadius: BorderRadius.circular(15)),
                              child: const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('+',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              220, 255, 255, 255),
                                          fontWeight: FontWeight.w200,
                                          fontSize: 36)),
                                  Text(
                                    'Add your address',
                                    style: TextStyle(
                                      
                                        color:
                                            Color.fromARGB(220, 255, 255, 255),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Stack(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: deviceHeight * 0.3,
                                    width: deviceWidth * 0.99,
                                    padding: const EdgeInsets.all(18),
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color.fromARGB(230, 0, 0, 0),
                                            Color.fromARGB(100, 0, 0, 0)
                                          ],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          saveAddress.userAdress[0]['name']
                                              .toString()
                                              .toUpperCase(),
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  222, 255, 255, 255),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 21),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: deviceHeight * 0.025,
                                              bottom: deviceHeight * 0.006),
                                          child: Text(
                                            saveAddress.userAdress[0]['city'] ??
                                                '',
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    222, 255, 255, 255),
                                               
                                                fontSize: 21),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              bottom: deviceHeight * 0.006),
                                          child: Text(
                                            saveAddress.userAdress[0]
                                                    ['homeAddress'] ??
                                                '',
                                            style: const TextStyle(
                                                color: Color.fromARGB(
                                                    180, 255, 255, 255),
                                               
                                                fontSize: 19),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: deviceHeight * 0.02),
                                          child: Text(
                                            '+92 ${saveAddress.userAdress[0]['number'] ?? ''}',
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    125, 250, 250, 250)),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                    color: Color.fromARGB(50, 255, 255, 255),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15),
                                        topRight: Radius.circular(15))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed(AddAddress.routeName);
                                        },
                                        icon: Icon(
                                          Icons.edit_note_outlined,
                                          color: const Color.fromARGB(
                                              255, 51, 243, 33),
                                          size: deviceWidth * 0.09,
                                        )),
                                    IconButton(
                                        onPressed: userConfirm,
                                        icon: Icon(
                                          Icons.delete,
                                          color: const Color.fromARGB(
                                              255, 242, 34, 19),
                                          size: deviceWidth * 0.075,
                                        )),
                                  ],
                                ),
                              )
                            ],
                          );
                        }
                      })),
            )));
  }
}
