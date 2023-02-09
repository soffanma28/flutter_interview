import 'package:flutter/material.dart';
import 'package:flutter_application_1/detail.dart';
import 'package:flutter_application_1/home.dart';

void main() async {
  runApp(const FlutterApp());
}

class FlutterApp extends StatelessWidget {
  const FlutterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter app',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/detail': (context) => DetailPage(id: 0),
      },
    );
  }
}