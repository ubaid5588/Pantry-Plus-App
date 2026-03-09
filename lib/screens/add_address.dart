import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_data_provider.dart';
import '../widgets/background_setup.dart';
import '../widgets/title_name.dart';

class AddAddress extends StatefulWidget {
  static const routeName = '/Add-Address';
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _MyAdreesState();
}

class _MyAdreesState extends State<AddAddress> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> sendAddress = {
    'name': '',
    'number': 0,
    'city': 'Mardan',
    'homeAddress': ''
  };

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final saveAddress = Provider.of<UserDataProvider>(context, listen: true);

    void saveForm() {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();

      saveAddress.addAddress(sendAddress['name'], sendAddress['number'],
          sendAddress['city'], sendAddress['homeAddress']);
      saveAddress.storeUserAddress();
    }

    return BackgroundSetup(
        centerWidget: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: const TitleName(title: 'Add Adress'),
            ),
            backgroundColor: Colors.transparent,
            body: Align(
              alignment: Alignment.topCenter,
              child: Container(
                alignment: Alignment.center,
                width: deviceWidth * 0.96,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(220, 255, 255, 255),
                    borderRadius: BorderRadius.circular(12)),
                height: deviceHeight * 0.5,
                padding: EdgeInsets.all(deviceWidth * 0.02),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: saveAddress.userAdress.isNotEmpty
                              ? saveAddress.userAdress[0]['name']
                              : '',
                          keyboardType: TextInputType.text,
                          onSaved: (value) {
                            sendAddress['name'] = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter contact name';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Contact name',
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: deviceWidth * 0.1,
                              child: TextFormField(
                                readOnly: true,
                                enabled: false,
                                decoration: const InputDecoration(
                                    labelText: '+92',
                                    labelStyle: TextStyle(color: Colors.black)),
                              ),
                            ),
                            SizedBox(
                              width: deviceWidth * 0.01,
                            ),
                            SizedBox(
                              width: deviceWidth * 0.79,
                              child: TextFormField(
                                initialValue: saveAddress.userAdress.isNotEmpty
                                    ? saveAddress.userAdress[0]['number']
                                    : '',
                                keyboardType: TextInputType.number,
                                onSaved: (value) {
                                  sendAddress['number'] = value;
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'please city name';
                                  }
                                  if (value.length < 10 || value.length > 10) {
                                    return 'please enter 10 digits number';
                                  }
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  labelText: 'Phone Number',
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: deviceWidth * 0.01,
                        ),
                        SizedBox(
                          // width: deviceWidth * 0.6,
                          child: TextFormField(
                            initialValue: 'Only available in Mardan city',
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              enabled: false,
                            ),
                          ),
                        ),
                        TextFormField(
                          initialValue: saveAddress.userAdress.isNotEmpty
                              ? saveAddress.userAdress[0]['homeAddress']
                              : '',
                          onSaved: (value) {
                            sendAddress['homeAddress'] = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'please enter home adress';
                            }
                            if (value.length < 15) {
                              return 'addrees should be correct';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            labelText: 'Home adress',
                          ),
                        ),
                        SizedBox(
                          height: deviceHeight * 0.042,
                        ),
                        SizedBox(
                          width: deviceWidth * 0.7,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                saveForm();
                                Navigator.of(context).pop();
                              }
                            },
                            style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                    const Color.fromARGB(255, 33, 68, 243))),
                            child: Text(
                              saveAddress.userAdress.isEmpty
                                  ? 'Save Address'
                                  : 'Update Address',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    )),
              ),
            )));
  }
}
