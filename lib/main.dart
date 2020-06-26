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
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text("++--"),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                  }),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                  child: Text("Kalkulator"),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => KalkulatorPage()));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}



