import 'package:flutter/widgets.dart';
import 'package:shaptifii/app/app.dart';
import 'package:shaptifii/home/home.dart';
import 'package:shaptifii/login/login.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
){
  switch(state){
    case AppStatus.authenticated:
      return[HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}