import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/background_setup.dart';
import '../widgets/title_name.dart';

class ContactUs extends StatelessWidget {
  static const routeName = '/contact-us';
  const ContactUs({super.key});

  Widget contactButton(
      VoidCallback directContact,
      Widget icon,
      String title,
      Color color,
      String link,
      BoxDecoration customDecoration,
      double dHeight,
      double dWidth) {
    return InkWell(
      onTap: () {
        directContact();
        // launchUrl(Uri.https(link));
      },
      child: Container(
        width: dWidth * 0.82,
        height: dHeight * 0.06,
        decoration: customDecoration,
        child: Padding(
          padding: EdgeInsets.only(left: dWidth * 0.05),
          child: Row(
            children: [
              icon,
              SizedBox(
                width: dWidth * 0.06,
              ),
              Text(
                title,
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w500,
                    fontSize: dHeight * 0.02),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    return BackgroundSetup(
        centerWidget: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const TitleName(title: 'Contact Us'),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
              width: deviceWidth * 0.97,
              
              decoration: BoxDecoration(
                  color: const Color.fromARGB(200, 255, 255, 255),
                  
                  borderRadius: BorderRadius.circular(12)),
              padding: EdgeInsets.all(deviceWidth * 0.02),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(deviceWidth * 0.035),
                    child: const Text(
                      'Contact Us',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Color.fromARGB(235, 33, 68, 243),
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        color: Color.fromARGB(255, 33, 68, 243),
                        shadows: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    'We value your feedback and are here to assist you with any concerns or complaints. If you have any issues or suggestions, please feel free to reach out to us.',
                    style: GoogleFonts.getFont(
                      'Poppins',
                      fontSize: 18,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(deviceWidth * 0.035),
                    child: const Text(
                      'Customer Support:',
                      style: TextStyle(
                        decorationColor: Color.fromARGB(235, 33, 68, 243),
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        color: Color.fromARGB(255, 33, 68, 243),
                        shadows: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                    ),
                  ),
                  contactButton(() {
                    const url = 'tel:+923492396193';
                    launchUrl(Uri.parse(url));
                  },
                      const Icon(
                        Icons.call,
                        color: Colors.white,
                      ),
                      'Call Us',
                      Colors.white,
                      '',
                      BoxDecoration(
                          color: const Color.fromARGB(235, 33, 68, 243),
                          borderRadius: BorderRadius.circular(12)),
                      deviceHeight,
                      deviceWidth),
                  SizedBox(height: deviceHeight * 0.015),
                  contactButton(() {
                    final whatsappUrl =
                        'https://wa.me/+923492396193?text=${Uri.encodeFull('Hello, I would like to inquire about your services.')}';
                    launchUrl(Uri.parse(whatsappUrl));
                  },
                      const FaIcon(
                        FontAwesomeIcons.whatsapp,
                        color: Colors.white,
                      ),
                      'Chat with WhatsApp',
                      Colors.white,
                      '',
                      BoxDecoration(
                          color: const Color.fromARGB(255, 6, 203, 13),
                          borderRadius: BorderRadius.circular(12)),
                      deviceHeight,
                      deviceWidth),
                  SizedBox(height: deviceHeight * 0.015),
                  contactButton(() {
                    const email = 'muhammadubaid2424@gmail.com';
                    const subject = 'Inquiry from Customer';
                    const body =
                        'Dear Shopkeeper,\n\nI have a few questions about your products.';

                    final url = Uri(
                      scheme: 'mailto',
                      path: email,
                      query:
                          'subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
                    ).toString();

                    launchUrl(Uri.parse(url));
                  },
                      const Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      'Email Us',
                      Colors.black,
                      '',
                      BoxDecoration(
                          color: const Color.fromARGB(100, 185, 180, 180),
                          border: Border.all(width: 1.4, color: Colors.black),
                          borderRadius: BorderRadius.circular(12)),
                      deviceHeight,
                      deviceWidth),
                  Padding(
                    padding: EdgeInsets.all(deviceWidth * 0.035),
                    child: const Text(
                      'Office Address:',
                      style: TextStyle(
                        decorationColor: Color.fromARGB(235, 33, 68, 243),
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        color: Color.fromARGB(255, 33, 68, 243),
                        shadows: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Pantry Plus \nCollage chowk Mardan \nMardan, KPK, 23200',
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(deviceWidth * 0.035),
                    child: const Text(
                      'Business Hours:',
                      style: TextStyle(
                        decorationColor: Color.fromARGB(235, 33, 68, 243),
                        fontWeight: FontWeight.w700,
                        fontSize: 22,
                        color: Color.fromARGB(255, 33, 68, 243),
                        shadows: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Monday - Friday: 9:00 AM - 6:00 PM \nSaturday: 10:00 AM - 4:00 PM \nSunday: Closed',
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontSize: 18,
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
