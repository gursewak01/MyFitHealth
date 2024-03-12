import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class test1 extends StatefulWidget {
  const test1({super.key});

  @override
  State<test1> createState() => _test1State();
}

class _test1State extends State<test1> {
  // Future<void> insertData() async {
  //   var uri = "http://localhost:3010/auth/signup";
  //   var data = {
  //     "username": "Shyam",
  //     "password": "shyam1",
  //     "email": "shyam@gmail.com",
  //     "age": 30,
  //     "gender": "male",
  //   };
  //   var body = json.encode(data);
  //   try {
  //     var response = await http.post(
  //       Uri.parse(uri),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //       body: body,
  //     );
  //     if (response.statusCode == 200) {
  //       // Handle successful response
  //       print('Data sent successfully');
  //       print('Response: ${response.body}');
  //     } else {
  //       // Handle errors
  //       print('Failed to send data. Error: ${response.reasonPhrase}');
  //     }
  //   } catch (error) {
  //     // Handle errors from the HTTP request
  //     print('Failed to send data. Error: $error');
  //   }
  // }

  //second code
  // Future<void> insertData() async {
  //     try {
  //       String uri = "http://localhost:3010/auth/signup";
  //       var res = await http.post(Uri.parse(uri), body: {
  //         "username": "Hari",
  //         "password": "hari1234",
  //         "email": "hari@gmail.com",
  //         "age": "21",
  //         "gender": "male",
  //       });

  //       var response = jsonDecode(res.body);
  //       if (response["message"] == "true") {
  //         print("Record Inserted");
  //       } else {
  //         print("some issue");
  //         print(response);
  //       }
  //     } catch (e) {
  //       print(e);
  //     }

  // }

  //check api connection
  Future<void> checkApiConnection() async {
    // Define your API endpoint
    var apiUrl = 'http://localhost:3010/auth/signup';

    try {
      // Make a GET request to the API endpoint
      var response = await http.post(Uri.parse(apiUrl));

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        print('API connection successful');
      } else {
        // Handle other status codes
        print('API connection failed. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle errors from the HTTP request
      print('API connection failed. Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(onPressed: checkApiConnection, child: Text("Test me!")),
        ),
      ),
    );
  }
}
