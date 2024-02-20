import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class User {
  final String username;
  final String password;

  User({required this.username, required this.password});

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
      };
}

class AuthService {
  static const apiUrl = 'http://localhost:81/UserData_api/login.php';

  static Future<bool> login(User user) async {
    final response = await http.post(
      Uri.parse('$apiUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      // Login successful
      // return true;
      print("true");
    } else {
      // Login failed
      // return false;
      print("false");

    }
  }
}

class LoginPage2 extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                ),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              ElevatedButton(
                onPressed: () async {
                  User user = User(
                    username: usernameController.text,
                    password: passwordController.text,
                  );
                  bool success = await AuthService.login(user);
                  if (success) {
                    // Navigate to the next screen
                  } else {
                    // Show error message
                  }
                },
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginPage2(),
  ));
}
