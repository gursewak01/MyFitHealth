import 'package:fitness_app/login.dart';
import 'package:fitness_app/signup.dart';
import 'package:flutter/material.dart';

import 'home.dart';
import 'login2.dart';
import 'splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // routes: {
      //   '/': (context) => const LoginPage(),
      //   '/register':(context) => const SignupPage(),
      // },
      home: SplashScreen(),
    );
  }
}
