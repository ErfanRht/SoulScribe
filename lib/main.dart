import 'package:flutter/material.dart';
import 'pages/intro/intro.dart';

void main() {
  runApp(const SoulScript());
}

class SoulScript extends StatelessWidget {
  const SoulScript({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SoulScript',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const IntroPage(),
    );
  }
}
