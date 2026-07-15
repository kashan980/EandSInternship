import 'package:eandsinternship/presentation/main_screen/main_screen.dart';
import 'package:eandsinternship/presentation/menu/menu.dart';
import 'package:flutter/material.dart';

class RouteHelperUtil {

  Widget getMainScreenWidget() {
    return  MainScreen();
  }
  Widget getMenuScreenWidget() {
    return  Menu();
  }
}