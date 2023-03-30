import 'dart:async';

import 'package:pomodoro/colors.dart';
import 'package:flutter/material.dart';

enum CurrentPage {
  pomodoro,
  shortBreak,
  timerRunning
}


class AppState extends ChangeNotifier{
  late CurrentPage page;
  late Color backgroundColor;
  late Color containerColor;
  AppState({required this.page}){
   changeTheme(page);
  }

  void changeTheme(CurrentPage page){
    if(page == CurrentPage.pomodoro){
      backgroundColor = AppColors.backgroundRed;
      containerColor = AppColors.containerRed;
      this.page = page;
      notifyListeners();
      return;
    }
    if(page == CurrentPage.shortBreak){
      backgroundColor = AppColors.backgroundBlue;
      containerColor = AppColors.containerBlue;
      this.page = page;
      notifyListeners();
      return;
    }
    if(page == CurrentPage.timerRunning){
      backgroundColor = AppColors.backgroundDim;
      containerColor = Colors.transparent;
      this.page = page;
      notifyListeners();
      return;
    }
  }
}

class TimerState extends ChangeNotifier{
  Timer? countDownTimer;
  Duration initialTime = const Duration(minutes: 25);
  late int remainingSeconds = initialTime.inSeconds.remainder(60);
  late int remainingMinutes = initialTime.inMinutes;
  bool timerRunning = false;

  void startTimer() {
    timerRunning = true;
    countDownTimer =
        Timer.periodic(const Duration(seconds: 1), (_) => countDown());
  }
  void pause({required bool pause}) {
      countDownTimer!.cancel();
      timerRunning = false;
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