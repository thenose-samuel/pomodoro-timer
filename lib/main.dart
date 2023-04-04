import 'package:flutter/material.dart';
import 'package:pomodoro/colors.dart';
import 'package:pomodoro/state.dart';
import 'package:provider/provider.dart';

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
      home: MultiProvider(providers: [
        ChangeNotifierProvider(
            create: (context) => AppState(page: CurrentPage.pomodoro)),
        ChangeNotifierProvider(create: (context) => TimerState()),
      ], child: const HomePage()),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          SizedBox(
            height: 70,
          ),
          Padding(
              padding: EdgeInsets.only(left: 15, right: 15), child: TopBar()),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Body(),
          ),
          SizedBox(
            height: 20,
          ),
          Text('inspired by pomofocus.io',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold))
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          'Hi, Marjiba',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ],
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, page, child) => AnimatedContainer(
        height: 350,
        curve: Curves.fastOutSlowIn,
        decoration: BoxDecoration(
            color: page.backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(35))),
        duration: const Duration(seconds: 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Consumer<TimerState>(
                builder: (context, timer, _) => GestureDetector(
                  onTap: () {
                    timer.pause(pause: true);
                    page.changeTheme(CurrentPage.pomodoro);
                    timer.setInitialTime(const Duration(minutes: 25));
                  },
                  child: Text('Pomodoro',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: page.page == CurrentPage.pomodoro
                              ? Colors.white
                              : Colors.grey,
                          fontSize: 16)),
                ),
              ),
              Consumer<TimerState>(
                builder: (context, timer, _) => GestureDetector(
                    onTap: () {
                      timer.pause(pause: true);
                      page.changeTheme(CurrentPage.shortBreak);
                      timer.setInitialTime(const Duration(minutes: 5));
                    },
                    child: Text('Short Break',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: page.page == CurrentPage.shortBreak
                                ? Colors.white
                                : Colors.grey,
                            fontSize: 16))),
              ),
              Consumer<TimerState>(builder: (context, timer, _) {
                return GestureDetector(
                  onTap: () {
                    timer.pause(pause: true);
                    page.changeTheme(CurrentPage.longBreak);
                    timer.setInitialTime(const Duration(minutes: 15));
                  },
                  child: Text('Long Break',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: page.page == CurrentPage.longBreak
                              ? Colors.white
                              : Colors.grey,
                          fontSize: 16)),
                );
              }),
            ]),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    curve: Curves.fastOutSlowIn,
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 30, right: 30),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(40)),
                      color: page.containerColor,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        CountdownTimer(),
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
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, page, child) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Consumer<TimerState>(
              builder: (context, timer, child) => Text(
                '${(timer.remainingMinutes < 10) ? '0' : ''}${timer.remainingMinutes}:${(timer.remainingSeconds < 10) ? '0' : ''}${timer.remainingSeconds}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 90,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Consumer<TimerState>(
            builder: (context, timer, child) => GestureDetector(
              onTap: () {
                if (!timer.timerRunning) {
                  // if (page.page == CurrentPage.shortBreak) {
                  //   timer.initialTime = const Duration(minutes: 5);
                  // }
                  timer.startTimer();
                } else {
                  timer.pause(pause: true);
                }
                // page.changeTheme(CurrentPage.timerRunning);
                if (page.page == CurrentPage.timerRunning) {
                  if (page.prevPage == CurrentPage.pomodoro) {
                    page.changeTheme(CurrentPage.pomodoro);
                  } else if (page.page == CurrentPage.shortBreak) {
                    page.changeTheme(CurrentPage.shortBreak);
                  } else {
                    page.changeTheme(CurrentPage.longBreak);
                  }
                } else {
                  page.changeTheme(CurrentPage.timerRunning);
                  return;
                }
              },
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(10),
                child: Text(
                  (!timer.timerRunning) ? 'START' : 'PAUSE',
                  style: TextStyle(
                      color: (!timer.timerRunning)
                          ? (page.page == CurrentPage.pomodoro)
                              ? AppColors.startPomodoro
                              : AppColors.startShortBreak
                          : Colors.black87,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
