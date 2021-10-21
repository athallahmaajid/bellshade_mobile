import 'package:flutter/material.dart';
import 'package:bellshade_mobile/view/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
      theme: ThemeData(
          backgroundColor: const Color(0xFF1e1e1e), primaryColor: const Color(0xFFededed), appBarTheme: const AppBarTheme(color: Color(0xFF4f4f4f))),
    );
  }
}
