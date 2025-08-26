import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../providers/auth_services.dart';
import '../screens/whole_screen.dart';
import 'verification_email_screen.dart';
import './signin_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({
    super.key,
  });
  static const String routeName = '/signup-screen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool isloading = false;
  final auth = AuthServices();
  final _formKey = GlobalKey<FormState>();

  Map<String, String> authData = {'fullName': '', 'email': '', 'password': ''};

  var passwordCheck = TextEditingController();

  Widget customDivider() {
    return const Divider(
      height: 1,
      thickness: 1.5,
      color: Colors.black38,
    );
  }

  void showErrorMessage(String text) {}

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    void saveForm(context, ctx) async {
      setState(() {
        isloading = true;
      });
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();
      try {
        final user = await auth.createUserWithEmailAndPassword(
            authData['email'] ?? '', authData['password'] ?? '');
        await user?.updateDisplayName(authData['fullName']);
        if (user != null) {
          setState(() {
            isloading = false;
          });
          if (user.emailVerified == false) {
            Navigator.of(context).pushNamed(VerificationEmailScreen.routeName);
          } else {
            Navigator.of(context).pushReplacementNamed(WholeScreen.routeName);
          }
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          isloading = false;
        });
        if (e.code == 'email-already-in-use') {
          if (ctx.mounted) {
            ScaffoldMessenger.of(ctx).clearSnackBars();
            ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text('This email alreay exaist.')));
          }
        }
      }
    }

    return MaterialApp(
        title: 'Pantry Plus',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Container(
            color: const Color.fromARGB(255, 33, 68, 243),
            child: Stack(
              children: [
                ClipPath(
                  clipper: CustomClipPath(),
                  child: SizedBox(
                      height: deviceHeight * 0.55,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/backgroundimage1.png',
                        fit: BoxFit.cover,
                      )),
                ),
                ClipRRect(
                  child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                      child: SizedBox(
                        width: double.infinity,
                        height: deviceHeight * 0.55,
                      )),
                ),
                Container(
                  padding: EdgeInsets.only(top: deviceHeight * 0.05),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        // width: deviceWidth * 0.9,
                        height: deviceHeight * 0.10,
                        child: Image.asset(
                          'assets/images/logo.png',
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                            child: SizedBox(
                              width: deviceWidth * 0.40,
                              height: deviceHeight * 0.050,
                              child: Center(
                                child: Text(
                                  'Pantry Plus',
                                  style: GoogleFonts.getFont(
                                    'Poppins',
                                    fontWeight: FontWeight.w500,
                                    fontSize: 21,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: deviceHeight * 0.03),
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                          width: deviceWidth * 0.86,
                          height: deviceHeight * 0.58,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.6),
                              border: Border.all(
                                  width: 2,
                                  color: Colors.white.withOpacity(0.8)),
                              borderRadius: BorderRadius.circular(25)),
                          child: Column(
                            children: [
                              Container(
                                  width: double.infinity,
                                  height: deviceHeight * 0.57,
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Text(
                                        'Welcome!',
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Form(
                                          key: _formKey,
                                          child: Container(
                                            height: deviceHeight * 0.35,
                                            width: deviceWidth * 0.73,
                                            padding: const EdgeInsets.only(
                                                left: 10, right: 10, top: 5),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                    width: 2,
                                                    color: Colors.white10),
                                                color: Colors.grey[200]),
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  keyboardType:
                                                      TextInputType.text,
                                                  onSaved: (value) {
                                                    authData['fullName'] =
                                                        value!;
                                                  },
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'please enter full name';
                                                    }

                                                    return null;
                                                  },
                                                  decoration: InputDecoration(
                                                    icon: const Icon(
                                                      Icons
                                                          .perm_identity_rounded,
                                                      size: 18,
                                                    ),
                                                    border: InputBorder.none,
                                                    constraints: BoxConstraints(
                                                        maxHeight:
                                                            deviceHeight *
                                                                0.08),
                                                    labelStyle: const TextStyle(
                                                        fontSize: 15),
                                                    errorStyle: const TextStyle(
                                                      fontSize: 11,
                                                    ),
                                                    labelText: 'Full Name',
                                                  ),
                                                ),
                                                customDivider(),
                                                TextFormField(
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  onSaved: (value) {
                                                    authData['email'] = value!;
                                                  },
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'please enter email';
                                                    }
                                                    if (!value.contains(
                                                        '@gmail.com')) {
                                                      return 'please enter a valide email';
                                                    }
                                                    return null;
                                                  },
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    constraints: BoxConstraints(
                                                        maxHeight:
                                                            deviceHeight *
                                                                0.08),
                                                    icon: const Icon(
                                                      Icons.email,
                                                      size: 18,
                                                    ),
                                                    labelStyle: const TextStyle(
                                                        fontSize: 15),
                                                    errorStyle: const TextStyle(
                                                      fontSize: 11,
                                                    ),
                                                    labelText: 'Email',
                                                  ),
                                                ),
                                                customDivider(),
                                                TextFormField(
                                                  obscureText: true,
                                                  controller: passwordCheck,
                                                  onSaved: (value) {
                                                    authData['password'] =
                                                        value!;
                                                  },
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'please enter password';
                                                    }
                                                    if (value.length <= 5) {
                                                      return 'passord must be greater than 6 digit';
                                                    }
                                                    return null;
                                                  },
                                                  decoration: InputDecoration(
                                                    icon: const Icon(
                                                      Icons.password_outlined,
                                                      size: 18,
                                                    ),
                                                    constraints: BoxConstraints(
                                                        maxHeight:
                                                            deviceHeight *
                                                                0.08),
                                                    border: InputBorder.none,
                                                    labelStyle: const TextStyle(
                                                        fontSize: 15),
                                                    errorStyle: const TextStyle(
                                                        fontSize: 11),
                                                    labelText: 'Password',
                                                  ),
                                                ),
                                                customDivider(),
                                                TextFormField(
                                                  obscureText: true,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'please enter password';
                                                    }
                                                    if (value !=
                                                        passwordCheck.text) {
                                                      return 'password must be match';
                                                    }
                                                    return null;
                                                  },
                                                  decoration: InputDecoration(
                                                    icon: const Icon(
                                                      Icons.password_outlined,
                                                      size: 18,
                                                    ),
                                                    constraints: BoxConstraints(
                                                        maxHeight:
                                                            deviceHeight *
                                                                0.08),
                                                    border: InputBorder.none,
                                                    labelStyle: const TextStyle(
                                                        fontSize: 15),
                                                    errorStyle: const TextStyle(
                                                        fontSize: 11),
                                                    labelText:
                                                        'Cornfirm Password',
                                                  ),
                                                ),
                                                customDivider()
                                              ],
                                            ),
                                          )),
                                      Builder(builder: (ctx) {
                                        return SizedBox(
                                          width: deviceWidth * 0.5,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    saveForm(context, ctx);
                                                  }
                                                },
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        WidgetStateProperty.all<
                                                                Color>(
                                                            const Color
                                                                .fromARGB(255,
                                                                33, 68, 243))),
                                                child: isloading
                                                    ? LoadingAnimationWidget
                                                        .flickr(
                                                        leftDotColor:
                                                            Colors.red,
                                                        rightDotColor:
                                                            Colors.yellow,
                                                        size: deviceHeight *
                                                            0.036,
                                                      )
                                                    : const Text(
                                                        'Sign up',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Already have an account?',
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pushReplacementNamed(
                                                    context,
                                                    SigninScreen.routeName);
                                              },
                                              child: Text(
                                                'Sign in here',
                                                style: TextStyle(
                                                    color: Colors.blue[900],
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    final lowpoint = size.height - 30;
    final highpoint = size.height - 60;

    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 4, highpoint, size.width / 2, lowpoint);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, lowpoint);

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
