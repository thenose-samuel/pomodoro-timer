import 'dart:async';
import 'dart:developer';

import 'package:pomodoro/colors.dart';
import 'package:flutter/material.dart';

enum CurrentPage { pomodoro, shortBreak, timerRunning, longBreak }

class AppState extends ChangeNotifier {
  late CurrentPage page;
  late CurrentPage prevPage;

  late Color backgroundColor;
  late Color containerColor;
  late Color startTextColor;

  AppState({required this.page}) {
    changeTheme(page);
  }

  void changeTheme(CurrentPage page) {
    prevPage = this.page;

    if (page == CurrentPage.pomodoro) {
      backgroundColor = AppColors.backgroundRed;
      containerColor = AppColors.containerRed;
      startTextColor = Colors.black38;
      this.page = page;
      notifyListeners();
      return;
    }

    if (page == CurrentPage.shortBreak) {
      backgroundColor = AppColors.backgroundBlue;
      containerColor = AppColors.containerBlue;
      startTextColor = Colors.black38;
      this.page = page;
      notifyListeners();
      return;
    }

    if (page == CurrentPage.longBreak) {
      backgroundColor = AppColors.backgroundDarkBlue;
      containerColor = AppColors.containerDarkBlue;
      startTextColor = Colors.black38;
      this.page = page;
      notifyListeners();
      return;
    }

    if (page == CurrentPage.timerRunning) {
      backgroundColor = AppColors.backgroundDim;
      containerColor = Colors.transparent;
      startTextColor = Colors.black38;
      this.page = page;
      notifyListeners();
      return;
    }
  }
}

class TimerState extends ChangeNotifier {
  Timer? countDownTimer;
  Duration initialTime = const Duration(seconds: 3);
  late int remainingSeconds = initialTime.inSeconds.remainder(60);
  late int remainingMinutes = initialTime.inMinutes;
  bool timerRunning = false;
  int currentPomodoro = 0;

  void setInitialTime(Duration init) {
    initialTime = init;
    remainingMinutes = initialTime.inMinutes;
    remainingSeconds = initialTime.inSeconds.remainder(60);
    notifyListeners();
  }

  void startTimer({AppState? appState, TimerState? timerState}) {
    timerRunning = true;
    countDownTimer = Timer.periodic(const Duration(seconds: 1),
        (_) => countDown(appState: appState, timerState: timerState));
    notifyListeners();
  }

  void pause({required bool pause}) {
    if (countDownTimer != null) countDownTimer!.cancel();
    timerRunning = false;
    notifyListeners();
  }

  void countDown({AppState? appState, TimerState? timerState}) {
    final seconds = initialTime.inSeconds - 1;
    if (seconds < 0) {
      // countDownTimer!.cancel();
      pause(pause: true);
      if (appState!.prevPage == CurrentPage.pomodoro) {
        //log('In to break change', name: 'Timer');
        currentPomodoro++;
        log('${currentPomodoro}', name: 'Timer');
        if (currentPomodoro % 4 == 0 && currentPomodoro != 0) {
          timerState!.initialTime = const Duration(seconds: 3);
          appState.changeTheme(CurrentPage.longBreak);
        } else {
          log('In to break change', name: 'Timer');
          timerState!.initialTime = const Duration(seconds: 3);
          appState.changeTheme(CurrentPage.shortBreak);
        }
      } else {
        timerState!.initialTime = const Duration(seconds: 3);
        appState.changeTheme(CurrentPage.pomodoro);
      }
    } else {
      initialTime = Duration(seconds: seconds);
    }
    remainingMinutes = initialTime.inMinutes;
    remainingSeconds = initialTime.inSeconds.remainder(60);
    notifyListeners();
  }
}
