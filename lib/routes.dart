import 'package:bloccalulate/ui/home_page.dart';
import 'package:bloccalulate/ui/kalkulator_page.dart';
import 'package:bloccalulate/ui/plesminus_page.dart';
import 'package:flutter/material.dart';

const String homeRoute = '/home';
const String plusMinusRoute = '/plusMinus';
const String kalkulatorRoute = '/kalkulator';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name){
    case homeRoute:
      return MaterialPageRoute(builder: (_) => HomePage());
    case plusMinusRoute:
      return MaterialPageRoute(builder: (_) => HomeScreen());
    case kalkulatorRoute :
      return MaterialPageRoute(builder: (_) => KalkulatorPage());
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
                child: Text('No route defined for ${settings.name}')),
          ));
  }
  }
}