import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {

final Function()? onTap;

const MyButton({super.key, required this.onTap});

@override
Widget build(BuildContext context) {
return GestureDetector(
onTap:onTap,
      child: Container(
padding: const EdgeInsets.all(25),
margin: const EdgeInsets.symmetric(horizontal: 25),
decoration: BoxDecoration(
color: Colors.blue,
borderRadius: BorderRadius. circular(8),
), // BoxDecoration
child: const Center(
child: Text(
"Sign In",
style: TextStyle(
color: Colors.white,
fontWeight: FontWeight.bold,
fontSize: 16,
), // TextStyle
), // Text
), // Center
), // Container
);
 }
 } 