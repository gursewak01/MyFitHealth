import 'package:fitness_app/test.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'signup.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // String? email = prefs.getString("email");
      // (email==null)?
      Navigator.of(context).pushReplacement
        (MaterialPageRoute(builder: (context )=> SignupPage()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("This is splash screen"),
          ],
        ),
      )
    );
  }
}