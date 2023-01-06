
import 'package:app_lokdon/View/home.dart';
import 'package:app_lokdon/View/login.dart';
import 'package:app_lokdon/splash_screen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp( const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      title: 'Flutter Demo',
      home: const SplashScreen(),
      routes: <String, WidgetBuilder>{
      '/login': (BuildContext context) => const FormLogin(),
      '/home': (BuildContext context) => const HomeScreen(),
    },
      debugShowCheckedModeBanner: false,
    );
     
  }
}