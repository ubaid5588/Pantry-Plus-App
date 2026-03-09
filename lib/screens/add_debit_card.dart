import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/background_setup.dart';
import '../widgets/title_name.dart';
import '../providers/user_data_provider.dart';

class AddDebitCard extends StatefulWidget {
  static const routeName = '/add-debit-card';
  const AddDebitCard({super.key});

  @override
  State<AddDebitCard> createState() => _AddDebitCardState();
}

class _AddDebitCardState extends State<AddDebitCard> {
  final _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> sendCredentional = {
    'cardNumber': '',
    'cardHolderName': '',
    'expireyDate': '',
    'cvcCode': ''
  };
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    final credentionalData =
        Provider.of<UserDataProvider>(context, listen: false);
    void saveForm() {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();
      credentionalData.addCredentional(sendCredentional);
    }

    return BackgroundSetup(
        centerWidget: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const TitleName(title: 'Add Debit Card'),
      ),
      backgroundColor: Colors.transparent,
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: deviceWidth * 0.96,
          height: deviceHeight * 0.5,
          decoration: BoxDecoration(
              color: const Color.fromARGB(220, 255, 255, 255),
             
              borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.all(deviceWidth * 0.02),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onSaved: (value) {
                      sendCredentional['cardNumber'] = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter your card number ';
                      }
                      if (value.length < 16) {
                        return 'please enter 16 number';
                      }
                      if (value.length > 16) {
                        return 'please enter 16 number';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Card number',
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.001,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    onSaved: (value) {
                      sendCredentional['cardHolderName'] = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter card holder name';
                      }

                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Card holder name',
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.datetime,
                    onSaved: (value) {
                      sendCredentional['expireyDate'] = value;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'please enter your card expirey date ';
                      }
                      if (!value.contains('/')) {
                        return 'please enter expirey date with / ';
                      }

                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Expirey Date : 12/27',
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: deviceWidth * 0.2,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        onSaved: (value) {
                          sendCredentional['cvcCode'] = value;
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter cvc code';
                          }
                          if (value.length < 3 && value.length > 3) {
                            return 'should be 3';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Cvc code',
                        ),
                      ),
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
                      child: const Text(
                        'Save credit information',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    ));
  }
}
