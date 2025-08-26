import 'package:flutter/material.dart';

import '../providers/auth_services.dart';
import '../widgets/background_setup.dart';
import '../widgets/title_name.dart';

class ForgotPassword extends StatefulWidget {
  static const String routeName = '/forgot-password';
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _VerificatioEmailScreenState();
}

class _VerificatioEmailScreenState extends State<ForgotPassword> {
  // final _email = TextEditingController();
  final _auth = AuthServices();
  late String email;
  final _formKey = GlobalKey<FormState>();

  void saveForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    await _auth.sendPassordResetLink(email);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          behavior: SnackBarBehavior.floating,
          content:
              Text('An email for password reset has been send to your email')));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return BackgroundSetup(
        centerWidget: Scaffold(
      appBar: AppBar(
        title: const TitleName(title: 'Forgot Password'),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.transparent,
      body: Container(
          padding: EdgeInsets.only(top: deviceHeight * 0.04),
          height: deviceHeight * 0.95,
          child: Center(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/password_forgot.png',
                  height: deviceHeight * 0.16,
                ),
                SizedBox(
                  height: deviceHeight * 0.045,
                ),
                Container(
                  alignment: Alignment.center,
                  height: deviceHeight * 0.12,
                  width: deviceWidth * 0.97,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color.fromARGB(196, 255, 255, 255)),
                  padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.04),
                  child: Text(
                    'Enter email to send you a password reset email',
                    style: TextStyle(
                        fontSize: deviceWidth * 0.046, color: Colors.grey[800]),
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8)),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        // controller: _email,
                        onSaved: (value) {
                          email = value ?? '';
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please enter email';
                          }
                          if (!value.contains('@gmail.com')) {
                            return 'please enter valide email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          constraints: BoxConstraints(
                              maxHeight: deviceHeight * 0.08,
                              maxWidth: deviceWidth * 0.96),
                          labelStyle: const TextStyle(fontSize: 15),
                          errorStyle: const TextStyle(
                            fontSize: 11,
                          ),
                          icon: const Icon(
                            Icons.email,
                            size: 24,
                          ),
                          labelText: 'Email',
                        ),
                      ),
                    )),
                SizedBox(
                  height: deviceHeight * 0.02,
                ),
                ElevatedButton(
                    onPressed: saveForm,
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all<Color>(
                            const Color.fromARGB(255, 33, 68, 243))),
                    child: const Text(
                      'Send Email',
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            ),
          )),
    ));
  }
}
