import 'package:flutter/material.dart';
class CheckingAgeProvider extends ChangeNotifier{
  int _age=0;
  int get age =>_age;
  void setAge(int value){
    _age=value;
    notifyListeners();
  }
  bool get isEligible=>_age>=18;
}