// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:fitness_app/widgets/custom_widgets/widgets.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// import 'models/tutorial_model.dart';

// class Recommendations extends StatefulWidget {
//   const Recommendations({super.key, required this.BMI_Status});
//   final dynamic BMI_Status;

//   @override
//   State<Recommendations> createState() => _RecommendationsState();
// }

// class _RecommendationsState extends State<Recommendations> {
//   late YoutubePlayerController _controller;
//   String authToken =
//       'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1ZmQ0NWI5NWQ0OWM3MjFlN2QxMDQ2NSIsImlhdCI6MTcxMjQ4MTM0MSwiZXhwIjoxNzEyNTY3NzQxfQ.5NneUDqKb5o54zx18tumNk8OAnKHQXIJ2hwXz7YWc0g';
//   Future<List<TutorialModel>> fetchPosts() async {
//     var client = http.Client();
//     final response = await client.get(
//         Uri.parse('http://localhost:3001/tutorial/all-tutorial'),
//         headers: {
//           'Authorization': 'Bearer $authToken',
//           'Content-Type': 'application/json',
//         });
//     if (response.statusCode == 200) {
//       print("connection success");
//       List<dynamic> data = jsonDecode(response.body);
//       return data.map((json) => TutorialModel.fromJson(json)).toList();
//     } else {
//       print(response.body);
//       throw Exception("Failed to load posts");
//     }
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _controller = YoutubePlayerController(
//       initialVideoId: 'cbKkB3POqaY',
//       flags: YoutubePlayerFlags(
//         autoPlay: true,
//         mute: false
//       )
//     );
//   }
 
//   textRecommendation() {
//     if (widget.BMI_Status == "Underweight") {
//       return Column(
//         children: [
//           Text(
//             "You are underweight and need to gain some weight. Here is some of help!",
//             style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(
//             height: 6,
//           ),
//           Container(
//             width: 280,
//             child: Column(
//               children: [
//                 PointText(
//                     "1.  Aim to increase calorie intake through nutrient-dense foods."),
//                 SizedBox(
//                   height: 4,
//                 ),
//                 PointText(
//                     "2.  Include healthy fats, proteins, and complex carbohydrates in meals."),
//                 SizedBox(
//                   height: 4,
//                 ),
//                 PointText(
//                     "3.  Incorporate strength training exercises to build muscle mass."),
//                 SizedBox(
//                   height: 4,
//                 ),
//                 PointText(
//                     "4.  Consult with a healthcare professional or dietitian for personalized advice."),
//               ],
//             ),
//           )
//         ],
//       );
//     } else if (widget.BMI_Status == "Overweight") {
//       return Column(
//         children: [
//           Text(
//             "You fall in Overweight category and need to loose some weight. Here is some of help!",
//             style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(
//             height: 6,
//           ),
//           Container(
//             width: 280,
//             child: Column(
//               children: [
//                 PointText(
//                     "1.  Gradually reduce calorie intake by choosing smaller portions and limiting high-calorie foods."),
//                 SizedBox(
//                   height: 4,
//                 ),
//                 PointText(
//                     "2.  Increase physical activity levels with a combination of cardio and strength training exercises."),
//                 SizedBox(
//                   height: 4,
//                 ),
//                 PointText(
//                     "3.  Prioritize whole foods over processed or high-sugar options."),
//               ],
//             ),
//           )
//         ],
//       );
//     } else if (widget.BMI_Status == "Healthy") {
//       return Column(
//         children: [
//           Text(
//             "Congrats! You are Healthy. But keep on maintain your health!",
//             style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(
//             height: 6,
//           ),
//           Container(
//             width: 280,
//             child: Column(
//               children: [
//                 PointText(
//                     "1.  Maintain a balanced diet with a variety of fruits, vegetables, whole grains, lean proteins, and healthy fats."),
//                 SizedBox(
//                   height: 4,
//                 ),
//                 PointText(
//                     "2.  Engage in regular physical activity for overall health and fitness."),
//                 SizedBox(
//                   height: 4,
//                 ),
//                 PointText(
//                     "3.  Focus on maintaining a healthy lifestyle rather than weight management alone."),
//               ],
//             ),
//           )
//         ],
//       );
//     } else {
//       return Column(
//         children: [
//           Text(
//             "You fall in Obese category and really need to loose weight. Here is some of your help!",
//             style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(
//             height: 6,
//           ),
//           Container(
//             width: 280,
//             child: Column(
//               children: [
//                 PointText(
//                     "1.  Implement dietary changes such as reducing portion sizes, cutting back on sugary beverages and snacks, and increasing intake of fruits, vegetables, and lean proteins."),
//                 SizedBox(
//                   height: 4,
//                 ),
//                 PointText(
//                     "2.  Engage in regular aerobic exercise along with strength training to promote weight loss and improve overall health."),
//                 SizedBox(
//                   height: 4,
//                 ),
//                 PointText(
//                     "3.  Consider seeking support from a healthcare provider, registered dietitian, or weight loss program for guidance and accountability."),
//               ],
//             ),
//           )
//         ],
//       );
//     }
//   }

//   tutorial_recommendation(tutorial) {
//     if (widget.BMI_Status == "Underweight") {
//       return Row(
//         children: [
//           Expanded(
//               child: SizedBox(
//             height: 300,
//             child: ListView.builder(
//                 itemCount: tutorial.length > 8 ? tutorial.length - 14 : 0,
//                 itemBuilder: (BuildContext context, index) {
//                   final dataIndex = index + 8;
//                   return Padding(
//                     padding: EdgeInsets.all(6),
//                     child: Container(
//                       width: double.infinity,
//                       padding: EdgeInsets.all(16),
//                       height: 104,
//                       decoration: BoxDecoration(
//                           shape: BoxShape.rectangle,
//                           color: Color.fromARGB(255, 16, 133, 228),
//                           borderRadius: BorderRadius.all(Radius.circular(28))),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                          Container(
//                             width: 140,
//                             height: 120,
//                             child: TText("${tutorial[dataIndex].title}"),
//                           ),
//                           Container(
//                               padding: EdgeInsets.only(top: 16,left: 10),
//                               alignment: Alignment.bottomRight,
//                               child: ElevatedButton(
//                                   onPressed: () {
//                                     showDialog(
//                                       context: context,
//                                       barrierDismissible: false,
//                                       builder: (BuildContext context) {
//                                         return AlertDialog(
//                                           title: Text(
//                                               '${tutorial[dataIndex].title}'),
//                                           content: Column(
//                                             children: [
//                                               Text(
//                                                 '${tutorial[dataIndex].description}',
//                                                 style: TextStyle(fontSize: 12),
//                                               ),
//                                               SizedBox(
//                                                 height: 20,
//                                               ),
//                                               YoutubePlayer(
//                                                 controller:
//                                                     YoutubePlayerController(
//                                                   initialVideoId:
//                                                       '${tutorial[dataIndex].videoUrl}',
//                                                   flags: YoutubePlayerFlags(
//                                                       autoPlay: true,
//                                                       mute: false),
//                                                 ),
//                                                 showVideoProgressIndicator:
//                                                     true,
//                                                 progressIndicatorColor:
//                                                     Colors.blueAccent,
//                                               ),
//                                               FloatingActionButton(
//                                                   onPressed: () {
//                                                 setState(() {
//                                                   if (_controller
//                                                       .value.isPlaying) {
//                                                     _controller.pause();
//                                                   } else {
//                                                     _controller.play();
//                                                   }
//                                                 });
//                                               }),
//                                               Icon(_controller.value.isPlaying
//                                                   ? Icons.pause
//                                                   : Icons.play_arrow)
//                                             ],
//                                           ),
//                                           actions: <Widget>[
//                                             TextButton(
//                                               onPressed: () {
//                                                 Navigator.of(context).pop();
//                                               },
//                                               child: Text('Close'),
//                                             ),
//                                           ],
//                                         );
//                                       },
//                                     );
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     foregroundColor:
//                                         Color.fromARGB(255, 9, 105, 184),
//                                     backgroundColor: Colors.white,
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 26, vertical: 15),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10.0),
//                                     ),
//                                     elevation: 5,
//                                   ),
//                                   child: Text("Try")))
//                         ],
//                       ),
//                     ),
//                   );
//                 }),
//           ))
//         ],
//       );
//     } else if (widget.BMI_Status == "Healthy") {
//       return Row(
//         children: [
//           Expanded(
//               child: SizedBox(
//             height: 300,
//             child: ListView.builder(
//                 itemCount: tutorial.length > 10 ? tutorial.length - 14 : 0,
//                 itemBuilder: (BuildContext context, index) {
//                   final dataIndex = index + 10;
//                   return Padding(
//                     padding: EdgeInsets.all(6),
//                     child: Container(
//                       width: double.infinity,
//                       padding: EdgeInsets.all(16),
//                       height: 104,
//                       decoration: BoxDecoration(
//                           shape: BoxShape.rectangle,
//                           color: Color.fromARGB(255, 16, 133, 228),
//                           borderRadius: BorderRadius.all(Radius.circular(28))),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             width: 140,
//                             height: 120,
//                             child: TText("${tutorial[dataIndex].title}"),
//                           ),
//                           Container(
//                               padding: EdgeInsets.only(top: 16,left:10),
//                               alignment: Alignment.bottomRight,
//                               child: ElevatedButton(
//                                   onPressed: () {
//                                     showDialog(
//                                       context: context,
//                                       barrierDismissible: false,
//                                       builder: (BuildContext context) {
//                                         return AlertDialog(
//                                           title: Text(
//                                               '${tutorial[dataIndex].title}'),
//                                           content: Column(
//                                             children: [
//                                               Text(
//                                                 '${tutorial[dataIndex].description}',
//                                                 style: TextStyle(fontSize: 12),
//                                               ),
//                                               SizedBox(
//                                                 height: 20,
//                                               ),
//                                               YoutubePlayer(
//                                                 controller:
//                                                     YoutubePlayerController(
//                                                   initialVideoId:
//                                                       '${tutorial[dataIndex].videoUrl}',
//                                                   flags: YoutubePlayerFlags(
//                                                       autoPlay: true,
//                                                       mute: false),
//                                                 ),
//                                                 showVideoProgressIndicator:
//                                                     true,
//                                                 progressIndicatorColor:
//                                                     Colors.blueAccent,
//                                               ),
//                                               FloatingActionButton(
//                                                   onPressed: () {
//                                                 setState(() {
//                                                   if (_controller
//                                                       .value.isPlaying) {
//                                                     _controller.pause();
//                                                   } else {
//                                                     _controller.play();
//                                                   }
//                                                 });
//                                               }),
//                                               Icon(_controller.value.isPlaying
//                                                   ? Icons.pause
//                                                   : Icons.play_arrow)
//                                             ],
//                                           ),
//                                           actions: <Widget>[
//                                             TextButton(
//                                               onPressed: () {
//                                                 Navigator.of(context).pop();
//                                               },
//                                               child: Text('Close'),
//                                             ),
//                                           ],
//                                         );
//                                       },
//                                     );
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     foregroundColor:
//                                         Color.fromARGB(255, 9, 105, 184),
//                                     backgroundColor: Colors.white,
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 26, vertical: 15),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10.0),
//                                     ),
//                                     elevation: 5,
//                                   ),
//                                   child: Text("Try")))
//                         ],
//                       ),
//                     ),
//                   );
//                 }),
//           ))
//         ],
//       );
//     } else if (widget.BMI_Status == "Overweight") {
//       return Row(
//         children: [
//           Expanded(
//               child: SizedBox(
//             height: 300,
//             child: ListView.builder(
//                 itemCount: tutorial.length > 12 ? tutorial.length - 14 : 0,
//                 itemBuilder: (BuildContext context, index) {
//                   final dataIndex = index + 12;
//                   return Padding(
//                     padding: EdgeInsets.all(6),
//                     child: Container(
//                       width: double.infinity,
//                       padding: EdgeInsets.all(16),
//                       height: 104,
//                       decoration: BoxDecoration(
//                           shape: BoxShape.rectangle,
//                           color: Color.fromARGB(255, 16, 133, 228),
//                           borderRadius: BorderRadius.all(Radius.circular(28))),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             width: 140,
//                             height: 120,
//                             child: TText("${tutorial[dataIndex].title}"),
//                           ),
//                           Container(
//                               padding: EdgeInsets.only(top: 16, left: 10),
//                               alignment: Alignment.bottomRight,
//                               child: ElevatedButton(
//                                   onPressed: () {
//                                     showDialog(
//                                       context: context,
//                                       barrierDismissible: false,
//                                       builder: (BuildContext context) {
//                                         return AlertDialog(
//                                           title: Text(
//                                               '${tutorial[dataIndex].title}'),
//                                           content: Column(
//                                             children: [
//                                               Text(
//                                                 '${tutorial[dataIndex].description}',
//                                                 style: TextStyle(fontSize: 12),
//                                               ),
//                                               SizedBox(
//                                                 height: 20,
//                                               ),
//                                               YoutubePlayer(
//                                                 controller:
//                                                     YoutubePlayerController(
//                                                   initialVideoId:
//                                                       '${tutorial[dataIndex].videoUrl}',
//                                                   flags: YoutubePlayerFlags(
//                                                       autoPlay: true,
//                                                       mute: false),
//                                                 ),
//                                                 showVideoProgressIndicator:
//                                                     true,
//                                                 progressIndicatorColor:
//                                                     Colors.blueAccent,
//                                               ),
//                                               FloatingActionButton(
//                                                   onPressed: () {
//                                                 setState(() {
//                                                   if (_controller
//                                                       .value.isPlaying) {
//                                                     _controller.pause();
//                                                   } else {
//                                                     _controller.play();
//                                                   }
//                                                 });
//                                               }),
//                                               Icon(_controller.value.isPlaying
//                                                   ? Icons.pause
//                                                   : Icons.play_arrow)
//                                             ],
//                                           ),
//                                           actions: <Widget>[
//                                             TextButton(
//                                               onPressed: () {
//                                                 Navigator.of(context).pop();
//                                               },
//                                               child: Text('Close'),
//                                             ),
//                                           ],
//                                         );
//                                       },
//                                     );
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     foregroundColor:
//                                         Color.fromARGB(255, 9, 105, 184),
//                                     backgroundColor: Colors.white,
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 26, vertical: 15),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10.0),
//                                     ),
//                                     elevation: 5,
//                                   ),
//                                   child: Text("Try")))
//                         ],
//                       ),
//                     ),
//                   );
//                 }),
//           ))
//         ],
//       );
//     } else {
//       return Row(
//         children: [
//           Expanded(
//               child: SizedBox(
//             height: 300,
//             child: ListView.builder(
//                 itemCount: tutorial.length > 14 ? tutorial.length - 14 : 0,
//                 itemBuilder: (BuildContext context, index) {
//                   final dataIndex = index + 14;
//                   return Padding(
//                     padding: EdgeInsets.all(6),
//                     child: Container(
//                       width: double.infinity,
//                       padding: EdgeInsets.all(16),
//                       height: 104,
//                       decoration: BoxDecoration(
//                           shape: BoxShape.rectangle,
//                           color: Color.fromARGB(255, 16, 133, 228),
//                           borderRadius: BorderRadius.all(Radius.circular(28))),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Container(
//                             width: 140,
//                             height: 120,
//                             child: TText("${tutorial[dataIndex].title}"),
//                           ),
//                           Container(
//                               padding: EdgeInsets.only(top: 16,left:10 ),
//                               alignment: Alignment.bottomRight,
//                               child: ElevatedButton(
//                                   onPressed: () {
//                                     showDialog(
//                                       context: context,
//                                       barrierDismissible: false,
//                                       builder: (BuildContext context) {
//                                         return AlertDialog(
//                                           title: Text(
//                                               '${tutorial[dataIndex].title}'),
//                                           content: Column(
//                                             children: [
//                                               Text(
//                                                 '${tutorial[dataIndex].description}',
//                                                 style: TextStyle(fontSize: 12),
//                                               ),
//                                               SizedBox(
//                                                 height: 20,
//                                               ),
//                                               YoutubePlayer(
//                                                 controller:
//                                                     YoutubePlayerController(
//                                                   initialVideoId:
//                                                       '${tutorial[dataIndex].videoUrl}',
//                                                   flags: YoutubePlayerFlags(
//                                                       autoPlay: true,
//                                                       mute: false),
//                                                 ),
//                                                 showVideoProgressIndicator:
//                                                     true,
//                                                 progressIndicatorColor:
//                                                     Colors.blueAccent,
//                                               ),
//                                               FloatingActionButton(
//                                                   onPressed: () {
//                                                 setState(() {
//                                                   if (_controller
//                                                       .value.isPlaying) {
//                                                     _controller.pause();
//                                                   } else {
//                                                     _controller.play();
//                                                   }
//                                                 });
//                                               }),
//                                               Icon(_controller.value.isPlaying
//                                                   ? Icons.pause
//                                                   : Icons.play_arrow)
//                                             ],
//                                           ),
//                                           actions: <Widget>[
//                                             TextButton(
//                                               onPressed: () {
//                                                 Navigator.of(context).pop();
//                                               },
//                                               child: Text('Close'),
//                                             ),
//                                           ],
//                                         );
//                                       },
//                                     );
//                                   },
//                                   style: ElevatedButton.styleFrom(
//                                     foregroundColor:
//                                         Color.fromARGB(255, 9, 105, 184),
//                                     backgroundColor: Colors.white,
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 26, vertical: 15),
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(10.0),
//                                     ),
//                                     elevation: 5,
//                                   ),
//                                   child: Text("Try")))
//                         ],
//                       ),
//                     ),
//                   );
//                 }),
//           ))
//         ],
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             icon: Icon(Icons.arrow_back_ios)),
//         title: Text("Recommedations"),
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: FutureBuilder<List<TutorialModel>>(
//           future: fetchPosts(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return CircularProgressIndicator();
//             } else if (snapshot.hasError) {
//               return Text('Error: ${snapshot.error}');
//             } else {
//               List<TutorialModel> tutorial = snapshot.data!;
//               return SingleChildScrollView(
//                 child: Container(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       MText("Hi Gursewak!"),
//                       SizedBox(
//                         height: 6,
//                       ),
//                       textRecommendation(),
//                       SizedBox(
//                         height: 8,
//                       ),
//                       BText(
//                           "Here are some tutorial recommendations based on your BMI"),
//                       tutorial_recommendation(tutorial),
//                     ],
//                   ),
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
