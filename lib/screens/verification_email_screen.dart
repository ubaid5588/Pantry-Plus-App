import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/signup_screen.dart';
import '../widgets/wrapper.dart';
import '../providers/auth_services.dart';
import '../widgets/title_name.dart';
import '../widgets/background_setup.dart';

class VerificationEmailScreen extends StatefulWidget {
  static const String routeName = '/verification-email-screen';
  const VerificationEmailScreen({super.key});

  @override
  State<VerificationEmailScreen> createState() =>
      _VerificatioEmailScreenState();
}

class _VerificatioEmailScreenState extends State<VerificationEmailScreen> {
  final _auth = AuthServices();
  late Timer timer;
  late Timer countdown;
  int _start = 60;
  @override
  void initState() {
    super.initState();
    _auth.sendEmailVerificationLink();
    startTimer();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      FirebaseAuth.instance.currentUser?.reload();
      if (FirebaseAuth.instance.currentUser!.emailVerified == true) {
        timer.cancel();
        countdown.cancel();
        Navigator.of(context).pushReplacementNamed(Wrapper.routeName);
      }
    });
  }

  void startTimer() {
    countdown = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start > 0) {
        setState(() {
          _start--;
        });
      } else {
      
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return BackgroundSetup(
        centerWidget: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const TitleName(title: 'Verfication Email'),
      ),
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.only(top: deviceHeight * 0.05),
        height: deviceHeight * 0.95,
        child: Center(
          child: Column(
            children: [
              Image.asset(
                'assets/images/mail.png',
                height: deviceHeight * 0.15,
              ),
              SizedBox(
                height: deviceHeight * 0.045,
              ),
              Container(
                alignment: Alignment.center,
                height: deviceHeight * 0.16,
                width: deviceWidth * 0.97,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Color.fromARGB(196, 255, 255, 255)),
                padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.04),
                child: Text(
                  'We have sent an email for verification. if you haven\'t received an eamil, Please tap on resend email',
                  style: TextStyle(
                      fontSize: deviceWidth * 0.046, color: Colors.grey[800]),
                ),
              ),
              SizedBox(
                height: deviceHeight * 0.04,
              ),
              Text(
                'Please wait to send email again $_start sec',
                style: TextStyle(
                    fontSize: deviceWidth * 0.042, color: Colors.grey[800]),
              ),
              SizedBox(
                height: deviceHeight * 0.03,
              ),
              ElevatedButton(
                  onPressed: _start == 0
                      ? () async {
                          _auth.sendEmailVerificationLink();
                          setState(() {
                            _start = 60;
                          });
                        }
                      : null,
                  style: _start == 0
                      ? ButtonStyle(
                          backgroundColor: WidgetStateProperty.all<Color>(
                              const Color.fromARGB(255, 33, 68, 243)))
                      : null,
                  child: const Text(
                    'Resend Email',
                    style: TextStyle(color: Colors.white),
                  )),
              SizedBox(
                height: deviceHeight * 0.01,
              ),
              ElevatedButton(
                  onPressed: () {
                    countdown.cancel();
                    Navigator.of(context)
                        .pushReplacementNamed(SignupScreen.routeName);
                  },
                  child: const Text(
                    'Wrong email',
                  ))
            ],
          ),
        ),
      ),
    ));
  }
}
