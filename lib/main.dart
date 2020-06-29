import 'file:///D:/FlutterApp/Latihan/bloc_caculate/bloc_calulate/lib/bloc/bloc.dart';
import 'package:bloccalulate/routes.dart';
import 'package:bloccalulate/ui/kalkulator_page.dart';
import 'package:bloccalulate/ui/plesminus_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: Router.generateRoute,
      initialRoute: homeRoute ,
    );
  }
}
