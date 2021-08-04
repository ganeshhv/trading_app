
import 'package:flutter/material.dart';

class AppConstant
{
  static AppConstant _instance;
  factory AppConstant() => _instance ??= new AppConstant._();
  AppConstant._();

  bool isLoggedIn;

  bool isTabletDevice() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
    return data.size.shortestSide < 600 ? false : true;
  }

}