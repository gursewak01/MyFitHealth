import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:pedometer/pedometer.dart';

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
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = '?', _steps = '?';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
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
    return MaterialApp(
      home: Scaffold(
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
          child: Container(
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
                                          fontSize: 20, color: Colors.red),
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
                            itemCount: 5,
                            itemBuilder: (BuildContext context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue),
                                    borderRadius: BorderRadius.all(Radius.circular(18)),
                                    color: Colors.grey,
                                  ),
                                  width: 120,
                                  child: Text("abc"),
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
          ),
        ),
      ),
    );
  }
}