import 'dart:io';

import 'package:ecommerce_app/authentication/SingUp.dart';
import 'package:ecommerce_app/address/deliveryCheckOut.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../utils.dart';
import 'forgotPassword.dart';



class LoginPageN extends StatefulWidget {
  const LoginPageN({super.key});

  @override
  _LoginPageNState createState() => _LoginPageNState();
}

class _LoginPageNState extends State<LoginPageN> {
  bool obscureText = true;
  final emailController = TextEditingController();

  final nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final passwordController = TextEditingController();

  final imageController = TextEditingController();

  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }
  forgotPassword(context) {
    return GestureDetector(
      child: const Padding(
        padding: EdgeInsets.only(right: 7, bottom: 20),
        child: Text(
          'Forgot Password ?',
          style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 14,
              color: Colors.purple),
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const ForgotPasswordPage();
        }));
      },
    );
  }

  signup(context) {
    return OutlinedButton(
      onPressed: () {
        // Handle register
        Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(clickSignin: (){}),
                        ),
                      );
      },
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        side: BorderSide(color: Colors.teal[300]!),
      ),
      child: const Center(
        child: Text(
          'REGISTER',
          style: TextStyle(
            fontFamily: 'Helvetica',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );

  }

  Future signIn() async {
    final validValue = formKey.currentState?.validate();
    // if (validValue == null || !validValue) return;
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return const SizedBox(
              height: 5.0,
              width: 5.0,
              child: SpinKitRing(
                color: Colors.green,
                size: 60,
                duration: Duration(seconds: 60),
              ));
        });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      // Check if the widget is still mounted before navigating and correct context error
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) =>const DeliveryPageScreen()),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      //to create error message when user already exist or not
      Utils.showSnackBar(e.message);
    }
    //pop to the first page
    navigatorkey.currentState!.popUntil((route) => route.isFirst);
  }
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        print("Google Sign-In process canceled by user.");
        return null; // The user canceled the sign-in process.
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        print("Google Sign-In successful!");
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => DeliveryPageScreen()),
          );
        }
      } else {
        print("Google Sign-In failed: No user returned.");
      }

      return user;
    } catch (e) {
      print(" $e");
      Utils.showSnackBar('$e');

      // Additional error-specific handling can be done here, such as logging or re-attempting.
      return null;
    }
  }





  Future<User?> signInWithGoogleWeb() async {
    await Firebase.initializeApp();
    User? user;
    FirebaseAuth auth = FirebaseAuth.instance;
    GoogleAuthProvider authProvider = GoogleAuthProvider();

    try {
      final UserCredential userCredential = await auth.signInWithPopup(authProvider);
      user = userCredential.user;

      if (user != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setBool('auth', true);

        // Perform any additional logic, e.g., storing user data
      }
    } catch (e) {
      print(e); // Handle errors here, e.g., by logging or showing a message
    }

    // Ensure the widget is still mounted before using the context
    if (mounted && user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DeliveryPageScreen()),
      );
    }

    return user;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
           Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Center(
              child: Column(
                children: [
                  Text(
                    'WELCOME BACK',
                    style:  GoogleFonts.oswald(
                      textStyle:  const TextStyle(

                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),

        ),




                  ),

                  const SizedBox(height: 8),
                Text(
                    "It's good to see you again",
                      style:  GoogleFonts.poppins(
                        textStyle:  const TextStyle(
                          fontFamily: 'Helvetica',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                        ),

                      )
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            const TextField(
              decoration: InputDecoration(
                labelText: 'EMAIL ADDRESS',
                labelStyle: TextStyle(
                  fontFamily: 'Arial',
                  color: Colors.grey,
                ),
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(8.0),
                // ),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              obscureText: obscureText,
              decoration: InputDecoration(
                labelText: 'PASSWORD',
                labelStyle: const TextStyle(
                  fontFamily: 'Arial',
                  color: Colors.grey,
                ),
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(8.0),
                // ),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: togglePasswordVisibility,
                ),
              ),
            ),
            const SizedBox(height: 10),
             Align(
              alignment: Alignment.centerLeft,
              child: forgotPassword(context),
            ),

            const SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                // Handle sign in
                signIn();

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[300], // background color
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: Center(
                child: Text(

                  'SIGN IN',
                  style: GoogleFonts.poppins(


                  )
                ),
              ),
            ),
            const SizedBox(height: 80),
             Center(
              child: Text(
                "DON'T HAVE AN ACCOUNT?",
                style: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.black12,

                  )

    )
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 36,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10)),
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ),
              child: InkWell(
                onTap: () {
                  //choosing platform
                  if (!kIsWeb && Platform.isAndroid) {
                    signInWithGoogle() ;
                  } else if (kIsWeb) {
                    signInWithGoogleWeb();
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Row(
                    children: [
                      Image(
                          height: 25,
                          width: 25,
                          image:
                          AssetImage('assets/images/google.png')),
                      SizedBox(
                        width: 35,
                      ),
                      Center(child: Text('Continue with Google'))
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            signup(context),
          ],
        ),
      ),
    );
  }
}