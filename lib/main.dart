import 'package:ecommerce_app/home/homePage_widget.dart';

import 'package:ecommerce_app/provider/cart_provider.dart';
import 'package:ecommerce_app/provider/favorite_provider.dart';
import 'package:ecommerce_app/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'authentication/emailVerification.dart';
import 'firebase_options.dart';

Future<void> main() async {
  runApp(const EcommerceApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}
final navigatorkey = GlobalKey<NavigatorState>();
class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => FavoriteProvider()),
          ChangeNotifierProvider.value(value: CartProvider()),
          //ChangeNotifierProvider(create: (_) => CartProvider()),
        ],
        child: MaterialApp(
          color: Colors.grey[800],
          title: 'Market',
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: messengerkey,
          navigatorKey: navigatorkey,

          // theme: ThemeData(
          //   colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          //   useMaterial3: true,
          // ),
          theme: ThemeData(
              useMaterial3: true,
              primarySwatch: Colors.grey,
              visualDensity: VisualDensity.adaptivePlatformDensity,
              brightness: Brightness.light,
              fontFamily: 'Roboto',
              textTheme: TextTheme(
                titleLarge: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                bodyMedium: TextStyle(color: Colors.grey[800]),
                labelLarge: const TextStyle(color: Colors.white, fontSize: 16),
              )),
          home: const HomePage(),
          // home: StreamBuilder<User?>(
          //     stream: FirebaseAuth.instance.authStateChanges(),
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return const Center(
          //             child: SizedBox(
          //               height: 5,
          //               width: 5,
          //               child: CircularProgressIndicator(
          //                 color: Colors.blueAccent,
          //               ),
          //             ));
          //       } else if (snapshot.hasError) {
          //         return const Center(child: Text('Something went wrong'));
          //       } else if (snapshot.hasData) {
          //         return const EmailVerificationPage();
          //       } else {
          //         return const HomePage();
          //       }
          //     }),
        ),
      );
}
