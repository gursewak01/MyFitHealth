import 'package:fitness_app/widgets/custom_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Recommendations extends StatefulWidget {
  const Recommendations({super.key, required this.BMI_Status});
  final dynamic BMI_Status;

  @override
  State<Recommendations> createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  textRecommendation() {
    if (widget.BMI_Status == "Underweight") {
      return Text(
          "You are underweight and need to gain some weight. Here is some of help!", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),);
    } else if (widget.BMI_Status == "Overweight") {
      return Text(
          "You are underweight and need to loose some weight. Here is some of help!", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),);
    } else if (widget.BMI_Status == "Healthy") {
      return Text(
          "Congrats! You are Healthy. But keep on maintain your health!", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),);
    } else {
      return Text(
          "You are Obese and really need to loose weight. Here is some of your help!",style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_back_ios)),
        title: Text("Recommedations"),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MText("Hi Gursewak!"),
              textRecommendation(),
              BText("Here are some recommendations based on your BMI"),
              
            ],
          ),
        ),
      ),
    );
  }
}
