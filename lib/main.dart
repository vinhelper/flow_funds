import 'package:flow_funds/pages/init_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FlowFunds',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF48C9B3),
          // primary: Color(0xFF0CC0DF),
          // secondary: Color.fromRGBO(169, 204, 227, 1),
          // secondary: Color(0xFFA9CCE3),
          // tertiary: Color.fromRGBO(245, 245, 220, 1),
          // tertiary: Color(0xFFF5F5DC),
          // textColor with bg primary: Color(0xFF2C3E50)
        ),
      ),
      home: InitPage(),
    );
  }
}
