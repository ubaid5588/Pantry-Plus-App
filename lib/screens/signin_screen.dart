import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../providers/auth_services.dart';
import 'signup_screen.dart';
import './forgot_password.dart';
import 'verification_email_screen.dart';
import './whole_screen.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});
  static const String routeName = '/login-screen';

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool isloading = false;
  bool isLoadingGoogle = false;

  final auth = AuthServices();
  final _formKey = GlobalKey<FormState>();

  Map<String, String> authData = {'email': '', 'password': ''};

  Widget customDivider() {
    return const Divider(
      height: 1,
      thickness: 1.5,
      color: Colors.black38,
    );
  }

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
        final user = await auth.signInWithEmailAndPassword(
            authData['email'] ?? '', authData['password'] ?? '');
        if (user != null && user.emailVerified == true) {
          Navigator.of(context).pushReplacementNamed(WholeScreen.routeName);
        } else if (user != null && user.emailVerified == false) {
          Navigator.of(context).pushNamed(VerificationEmailScreen.routeName);
        }
      } on FirebaseAuthException catch (e) {
        setState(() {
          isloading = false;
        });

        if (e.code == 'invalid-credential') {
          if (ctx.mounted) {
            ScaffoldMessenger.of(ctx).clearSnackBars();
            ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(
                  'Check your email and password.',
                )));
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
                  padding: EdgeInsets.only(top: deviceHeight * 0.07),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 160,
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
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        width: deviceWidth * 0.86,
                        height: deviceHeight * 0.52,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            border: Border.all(
                                width: 2, color: Colors.white.withOpacity(0.8)),
                            borderRadius: BorderRadius.circular(25)),
                        child: Column(
                          children: [
                            Container(
                                width: double.infinity,
                                height: deviceHeight * 0.51,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      'Welcome back!',
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Form(
                                        key: _formKey,
                                        child: Container(
                                          height: deviceHeight * 0.20,
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
                                                    TextInputType.emailAddress,
                                                onSaved: (value) {
                                                  authData['email'] = value!;
                                                },
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'please enter email';
                                                  }
                                                  if (!value
                                                      .contains('@gmail.com')) {
                                                    return 'please enter valide email';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  constraints: BoxConstraints(
                                                      maxHeight:
                                                          deviceHeight * 0.08),
                                                  labelStyle: const TextStyle(
                                                      fontSize: 15),
                                                  errorStyle: const TextStyle(
                                                    fontSize: 11,
                                                  ),
                                                  icon: const Icon(
                                                    Icons.email,
                                                    size: 18,
                                                  ),
                                                  labelText: 'Email',
                                                ),
                                              ),
                                              customDivider(),
                                              TextFormField(
                                                obscureText: true,
                                                onSaved: (value) {
                                                  authData['password'] = value!;
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
                                                  border: InputBorder.none,
                                                  constraints: BoxConstraints(
                                                      maxHeight:
                                                          deviceHeight * 0.08),
                                                  labelStyle: const TextStyle(
                                                      fontSize: 15),
                                                  errorStyle: const TextStyle(
                                                    fontSize: 11,
                                                  ),
                                                  icon: const Icon(
                                                    Icons.password_outlined,
                                                    size: 18,
                                                  ),
                                                  labelText: 'Password',
                                                ),
                                              ),
                                              customDivider()
                                            ],
                                          ),
                                        )),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: deviceWidth * 0.08),
                                      child: Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            onTap: () => Navigator.of(context)
                                                .pushNamed(
                                                    ForgotPassword.routeName),
                                            child: const Text(
                                              'Forgot Password',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15),
                                              textAlign: TextAlign.end,
                                            ),
                                          )),
                                    ),
                                    Builder(builder: (ctx) {
                                      return SizedBox(
                                        width: deviceWidth * 0.6,
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
                                                          const Color.fromARGB(
                                                              255,
                                                              33,
                                                              68,
                                                              243))),
                                              child: isloading
                                                  ? LoadingAnimationWidget
                                                      .flickr(
                                                      leftDotColor: Colors.red,
                                                      rightDotColor:
                                                          Colors.yellow,
                                                      size:
                                                          deviceHeight * 0.036,
                                                    )
                                                  : const Text(
                                                      'Sign in',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                            ),
                                            SizedBox(
                                                width: deviceWidth * 0.5,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          WidgetStateProperty
                                                              .all<Color>(
                                                                  const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      255,
                                                                      255,
                                                                      255))),
                                                  onPressed: () async {
                                                    setState(() {
                                                      isLoadingGoogle = true;
                                                    });

                                                    await auth
                                                        .loginWithGoogle();

                                                    setState(() {
                                                      isLoadingGoogle = false;
                                                    });
                                                  },
                                                  child: isLoadingGoogle
                                                      ? LoadingAnimationWidget
                                                          .flickr(
                                                          leftDotColor:
                                                              Colors.red,
                                                          rightDotColor:
                                                              Colors.yellow,
                                                          size: deviceHeight *
                                                              0.036,
                                                        )
                                                      : Row(
                                                          children: [
                                                            Image.asset(
                                                              'assets/images/google_logo.png',
                                                              width:
                                                                  deviceWidth *
                                                                      0.062,
                                                              height:
                                                                  deviceHeight *
                                                                      0.044,
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  deviceWidth *
                                                                      0.02,
                                                            ),
                                                            const Text(
                                                              'Sign in with google',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            )
                                                          ],
                                                        ),
                                                ))
                                          ],
                                        ),
                                      );
                                    }),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Text(
                                          'don\'t have create one?',
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pushReplacementNamed(
                                                  context,
                                                  SignupScreen.routeName);
                                            },
                                            child: Text(
                                              'Sign up here',
                                              style: TextStyle(
                                                  color: Colors.blue[900],
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ))
                                      ],
                                    ),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ),
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
