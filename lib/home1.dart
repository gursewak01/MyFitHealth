import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:fitness_app/models/tutorial_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pedometer/pedometer.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:youtube_player_flutter_ifraim/youtube_player.dart';

import 'models/tutorial_model.dart';
import 'tutorialPage.dart';
import 'widgets/custom_widgets/widgets.dart';

String formatDate(DateTime d) {
  return d.toString().substring(0, 19);
}

class HomePage1 extends StatefulWidget {
  const HomePage1({super.key});

  @override
  State<HomePage1> createState() => _HomePage1State();
}

class _HomePage1State extends State<HomePage1> {
  late YoutubePlayerController _controller;
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = YoutubePlayerController(
        initialVideoId: 'cbKkB3POqaY',
        flags: YoutubePlayerFlags(autoPlay: true, mute: false));
    initPlatformState();
  }

  void fetchYouTubeData() async {
    final String apiKey =
        'AIzaSyAcy1_NzXYigcuoTxx1i_haQ_ZPsNDsKDA'; // Replace with your YouTube API key
    final String videoId =
        'cbKkB3POqaY'; // Replace with the YouTube video ID you want to fetch data for

    final String apiUrl =
        'https://www.googleapis.com/youtube/v3/videos?part=snippet&id=$videoId&key=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final String videoTitle = data['items'][0]['snippet']['title'];
      print('Video Title: $videoTitle');
    } else {
      print('Failed to fetch data. Status code: ${response.statusCode}');
    }
  }

  List<String> exerciseImages = [
    "assets/images/tutorial_images/workout.jpg",
    "assets/images/tutorial_images/cardio.jpg",
    "assets/images/tutorial_images/strength.jpg",
    "assets/images/tutorial_images/flexibility.jpg",
  ];

  List<TutorialModel> yogaTutorial = [];
  List<TutorialModel> exerciseTutorial = [];

  String authToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1ZmQ0NWI5NWQ0OWM3MjFlN2QxMDQ2NSIsImlhdCI6MTcxMjU3NzU0MSwiZXhwIjoxNzEyNjYzOTQxfQ.5zunSv8hTfOSOUbjy-6xAfJSFC5oRSc-2uUq10gHTfI';
  Future<List<TutorialModel>> fetchPosts() async {
    var client = http.Client();
    final response = await client.get(
        Uri.parse('http://localhost:3001/tutorial/all-tutorial'),
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        });
    if (response.statusCode == 200) {
      print("connection success");
      // print(response.body);
      List<dynamic> data = jsonDecode(response.body);
      
      return data.map((json) => TutorialModel.fromJson(json)).toList();
    } else {
      print(response.body);
      throw Exception("Failed to load posts");
    }
  }

  void onStepCount(StepCount event) {
    print(event);
    setState(() {
      _steps = event.steps.toString();
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Center(
              child: Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Text(
              "Home",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          )),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: InkWell(
                child: Container(
                  width: 40,
                  height: 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child:
                      ClipOval(child: Image.asset("assets/images/person.jpg")),
                ),
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: FutureBuilder<List<TutorialModel>>(
            future: fetchPosts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<TutorialModel> tutorial = snapshot.data!;
                tutorial.forEach((element) {
                  if(element.title.contains('yoga:')){
                    yogaTutorial.add(element);
                    // print(yogaTutorial[1].videoUrl);
                  }else if(element.title.contains('exercise:')){
                    exerciseTutorial.add(element);
                  }else {}
                });
                return Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height - 50,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        MText("Hi Gursewak!"),
                        BText("Get In Shape"),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 142,
                                height: 150,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18))),
                                child: Column(
                                  children: [
                                    Text("Steps Taken"),
                                    Text(_steps),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                width: 142,
                                height: 150,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(18))),
                                child: Column(
                                  children: [
                                    Text("Pedestrian Status"),
                                    Icon(
                                      _status == 'walking'
                                          ? Icons.directions_walk
                                          : _status == 'stopped'
                                              ? Icons.accessibility_new
                                              : Icons.error,
                                      size: 100,
                                    ),
                                    Center(
                                      child: Text(
                                        _status,
                                        style: _status == 'walking' ||
                                                _status == 'stopped'
                                            ? TextStyle(fontSize: 30)
                                            : TextStyle(
                                                fontSize: 20,
                                                color: Colors.red),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        BText("Polular Exercises"),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 120,
                                child: ListView.builder(
                                    // physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: exerciseTutorial.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      '${exerciseTutorial[index].title.replaceAll('exercise:', '')}'),
                                                  content: Column(
                                                    children: [
                                                      Text(
                                                        '${exerciseTutorial[index].description}',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      YoutubePlayer(
                                                        controller:
                                                            YoutubePlayerController(
                                                          initialVideoId:
                                                              '${exerciseTutorial[index].videoUrl}',
                                                          flags:
                                                              YoutubePlayerFlags(
                                                                  autoPlay:
                                                                      true,
                                                                  mute: false),
                                                        ),
                                                        // showVideoProgressIndicator:
                                                        //     true,
                                                        // progressIndicatorColor:
                                                        //     Colors.blueAccent,
                                                      ),
                                                      // _controller.value.isInitialized ? AspectRatio(aspectRatio: _controller.value.aspectRatio,
                                                      //        child: VideoPlayer(_controller),): CircularProgressIndicator(),
                                                      // FloatingActionButton(
                                                      //     onPressed: () {
                                                      //   setState(() {
                                                      //     if (_controller.value
                                                      //         .isPlaying) {
                                                      //       _controller.pause();
                                                      //     } else {
                                                      //       _controller.play();
                                                      //     }
                                                      //   });
                                                      // }),
                                                      // Icon(_controller
                                                      //         .value.isPlaying
                                                      //     ? Icons.pause
                                                      //     : Icons.play_arrow)
                                                    ],
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text('Close'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image: new DecorationImage(
                                                  image: new AssetImage(
                                                      "${exerciseImages[index]}"),
                                                  opacity: 0.3,
                                                  fit: BoxFit.fill),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(18)),
                                              // color: Colors.grey,
                                            ),
                                            width: 124,
                                            child: Container(
                                                margin: EdgeInsets.all(10),
                                                // height: 200,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  exerciseTutorial[index].title.replaceAll('exercise:', ''),
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                        BText("Polular Yoga"),
                        Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 120,
                                child: ListView.builder(
                                    // physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: yogaTutorial.length,
                                    itemBuilder: (BuildContext context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(
                                                      '${yogaTutorial[index].title.replaceAll('yoga:','')}'),
                                                  content: Column(
                                                    children: [
                                                      Text(
                                                        '${yogaTutorial[index].description}',
                                                        style: TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      YoutubePlayer(
                                                        controller:
                                                            YoutubePlayerController(
                                                          initialVideoId:
                                                              '${yogaTutorial[index].videoUrl}',
                                                          flags:
                                                              YoutubePlayerFlags(
                                                                  autoPlay:
                                                                      true,
                                                                  mute: false),
                                                        ),
                                                        // showVideoProgressIndicator:
                                                        //     true,
                                                        // progressIndicatorColor:
                                                        //     Colors.blueAccent,
                                                      ),
                                                      // _controller.value.isInitialized ? AspectRatio(aspectRatio: _controller.value.aspectRatio,
                                                      //        child: VideoPlayer(_controller),): CircularProgressIndicator(),
                                                      // FloatingActionButton(
                                                      //     onPressed: () {
                                                      //   setState(() {
                                                      //     if (_controller.value
                                                      //         .isPlaying) {
                                                      //       _controller.pause();
                                                      //     } else {
                                                      //       _controller.play();
                                                      //     }
                                                      //   });
                                                      // }),
                                                      // Icon(_controller
                                                      //         .value.isPlaying
                                                      //     ? Icons.pause
                                                      //     : Icons.play_arrow)
                                                    ],
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text('Close'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              image: new DecorationImage(
                                                  image: new AssetImage(
                                                      "${exerciseImages[index]}"),
                                                  opacity: 0.3,
                                                  fit: BoxFit.fill),
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(18)),
                                              // color: Colors.grey,
                                            ),
                                            width: 124,
                                            child: Container(
                                                margin: EdgeInsets.all(10),
                                                // height: 200,
                                                alignment: Alignment.center,
                                                child: Text(
                                                  yogaTutorial[index].title.replaceAll('yoga:',''),
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      );
    
  }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _controller.dispose();
  // }
}
