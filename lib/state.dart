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