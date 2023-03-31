import 'dart:async';

import 'package:pomodoro/colors.dart';
import 'package:flutter/material.dart';

enum CurrentPage { pomodoro, shortBreak, timerRunning }

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
  Duration initialTime = const Duration(minutes: 25);
  late int remainingSeconds = initialTime.inSeconds.remainder(60);
  late int remainingMinutes = initialTime.inMinutes;
  bool timerRunning = false;

  void setInitialTime(Duration init) {
    initialTime = init;
    remainingMinutes = initialTime.inMinutes;
    remainingSeconds = initialTime.inSeconds.remainder(60);
    notifyListeners();
  }

  void startTimer() {
    timerRunning = true;
    countDownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => countDown());
    notifyListeners();
  }

  void pause({required bool pause}) {
    countDownTimer!.cancel();
    timerRunning = false;
    notifyListeners();
  }

  void countDown() {
    final seconds = initialTime.inSeconds - 1;
    if (seconds < 0) {
      countDownTimer!.cancel();
    } else {
      initialTime = Duration(seconds: seconds);
      remainingMinutes = initialTime.inMinutes;
      remainingSeconds = initialTime.inSeconds.remainder(60);
    }
    notifyListeners();
  }
}
