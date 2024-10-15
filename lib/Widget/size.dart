import 'package:flutter/material.dart';

class SizesPage extends StatefulWidget {
  final String size;
  const SizesPage({super.key, required this.size});

  @override
  State<SizesPage> createState() => _SizesPageState();
}

class _SizesPageState extends State<SizesPage> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: Container(
        padding: const EdgeInsets.only(right: 16),
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.green),
        ),
        child: Text(
          widget.size,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
