import 'package:flutter/material.dart';
import 'package:stein_aplication/presentation/SplashScreen.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      theme: ThemeData(fontFamily: 'JosefinSans'),
    ),
  );
}
