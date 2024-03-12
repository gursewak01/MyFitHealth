import 'package:flutter/material.dart';

appbar(context) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    backgroundColor: Colors.purple.shade400,
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Icon(
            Icons.fitness_center_rounded,
            color: Colors.amber.shade200,
          ),
        ),
        SizedBox(
          width: 6,
        ),
        Text(
          "MyFitHealth",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: 6,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Icon(
            Icons.directions_run,
            size: 26,
            color: Colors.amber.shade200,
          ),
        ),
      ],
    ),
  );
}

BText(context) {
  return Text(context, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22));
}

MText(context) {
  return Text(context, style: TextStyle(color: Colors.black, fontSize: 15));
}