import 'dart:io';
import 'package:ecommerce_app/Widget/constant.dart';
import 'package:ecommerce_app/authentication/SingUp.dart';
import 'package:ecommerce_app/authentication/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class CheckoutScreenPage extends StatelessWidget {
  CheckoutScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const SizedBox(height: 50),
            // Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Looking for something?',
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 40),
            // Logo and Tagline
            Center(
              child: Text(
                'A & B STORE',
                style: GoogleFonts.bungee(
                  textStyle: const TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey, // Adjust color to match the logo
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Title
            const Text(
              'CRAFTED TO SUIT YOUR STYLE',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            // Subtitle
            const Text(
              'Sign in for endless Benefits',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 70),
            // Login Button
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginPageN()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00C1A1), // Teal color
                padding:
                const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'LOG IN',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            // Signup Button
            OutlinedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SignUpScreen(
                          clickSignin: () {

                          },
                        )));
              },
              style: OutlinedButton.styleFrom(
                padding:
                const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                side: const BorderSide(color: Colors.black45),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text(
                'JOIN UP',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black, // Black text color
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
