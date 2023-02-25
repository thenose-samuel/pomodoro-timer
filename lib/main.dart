import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

void main() {
  runApp(const PomodoroTimer());
}

class PomodoroTimer extends StatelessWidget {
  const PomodoroTimer({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Timer',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
              padding: EdgeInsets.only(left: 15, right: 15), child: TopBar()),
          const SizedBox(
            height: 20,
          ),
          Body(),
        ],
      ),
      backgroundColor: const Color(0xFF1a1a1a),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text(
            'Hi, Samuel',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Text(
            '25.02.2023',
            style: TextStyle(
                color: Color(0xFF858584),
                fontSize: 15,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.red[400],
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(35), topRight: Radius.circular(35))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 30, right: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      color: Colors.red[300],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CountdownTimer(),
                        GestureDetector(
                          onTap: () => {},
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(10),
                            child: const Text(
                              'START',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ],
                    ))
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // const Text('inspired by pomofocus.io', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold))
          ],
        ),
      ),
    );
  }
}

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({Key? key}) : super(key: key);
  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  Timer? countDownTimer;
  Duration initialTime = const Duration(minutes: 25);
  late int remainingSeconds = initialTime.inSeconds.remainder(60);
  late int remainingMinutes = initialTime.inMinutes;
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  void startTimer() {
    countDownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => countDown());
  }

  void countDown() {
    setState(() {
      final seconds = initialTime.inSeconds - 1;
      if (seconds < 0) {
        countDownTimer!.cancel();
      } else {
        initialTime = Duration(seconds: seconds);
        remainingMinutes = initialTime.inMinutes;
        remainingSeconds = initialTime.inSeconds.remainder(60);
      }
      log('${(remainingMinutes < 10)? '0': null} $remainingMinutes:${(remainingSeconds < 10)? '0': null}$remainingSeconds', name: 'time');
    });

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Text(
        '${(remainingMinutes < 10)? '0': ''} $remainingMinutes:${(remainingSeconds < 10)? '0': ''}$remainingSeconds',
        style: const TextStyle(
            color: Colors.white, fontSize: 90, fontWeight: FontWeight.bold),
      ),
    );
  }
}
