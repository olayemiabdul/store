import 'package:flutter/material.dart';

class SubcategoryScreen extends StatelessWidget {
  final String subcategory;

  const SubcategoryScreen({super.key, required this.subcategory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(subcategory),
      ),
      body: Center(
        child: Text(
          'Welcome to $subcategory category',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}