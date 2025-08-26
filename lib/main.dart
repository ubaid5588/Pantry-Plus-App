import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import './widgets/wrapper.dart';
import './providers/user_data_provider.dart';
import './providers/dummy_data.dart';
import './screens/splash.dart';
import '/screens/signin_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/whole_screen.dart';
import 'screens/verification_email_screen.dart';
import './screens/forgot_password.dart';
import 'screens/searching_screen.dart';
import './screens/products_screen.dart';
import './screens/product_detail_screen.dart';
import 'screens/my_address.dart';
import './screens/add_address.dart';
import 'screens/my_payment.dart';
import './screens/add_debit_card.dart';
import './screens/my_orders.dart';
import 'screens/contact_us.dart';
import './screens/payment_successful.dart';
import './screens/searched_screen.dart';
import './screens/order_detail_screen.dart';
import './screens/see_more_reviews.dart';
import './screens/show_all_orders.dart';
import './admin/add_product.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAA8GnQvXJF3ghHCUw0fjNB2v5WVPHOMHY",
          authDomain: "pantryplus-ab663.firebaseapp.com",
          projectId: "pantryplus-ab663",
          storageBucket: "pantryplus-ab663.appspot.com",
          messagingSenderId: "1038836549876",
          appId: "1:1038836549876:web:1f0e54d619359cb378b6a1"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserDataProvider()),
        ChangeNotifierProvider(create: (_) => DummyData())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter App',
        routes: {
          Splash.routeName: (ctx) => const Splash(),
          Wrapper.routeName: (ctx) => const Wrapper(),
          SigninScreen.routeName: (ctx) => const SigninScreen(),
          SignupScreen.routeName: (ctx) => const SignupScreen(),
          WholeScreen.routeName: (ctx) => const WholeScreen(),
          ForgotPassword.routeName: (ctx) => const ForgotPassword(),
          VerificationEmailScreen.routeName: (ctx) =>
              const VerificationEmailScreen(),
          SearchingScreen.routeName: (ctx) => const SearchingScreen(),
          SearchedScreen.routeName: (ctx) => const SearchedScreen(),
          ProductsScren.routeName: (ctx) => const ProductsScren(),
          ProductDetailScreen.routeName: (ctx) => const ProductDetailScreen(),
          MyAddress.routeName: (ctx) => const MyAddress(),
          AddAddress.routeName: (ctx) => const AddAddress(),
          Payment.routeName: (ctx) => const Payment(),
          AddDebitCard.routeName: (ctx) => const AddDebitCard(),
          MyOrders.routeName: (ctx) => const MyOrders(),
          ContactUs.routeName: (ctx) => const ContactUs(),
          PaymentSuccessful.routeName: (ctx) => const PaymentSuccessful(),
          OrderDetailScreen.routeName: (ctx) => const OrderDetailScreen(),
          SeeMoreReviews.routeName: (ctx) => const SeeMoreReviews(),
          ShowAllOrders.routeName: (ctx) => const ShowAllOrders(),
          AddEditProduct.routeName: (ctx) => const AddEditProduct()
        },
        home: const Scaffold(body: Splash()),
      ),
    );
  }
}
