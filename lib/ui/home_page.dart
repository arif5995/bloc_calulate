import 'package:bloccalulate/routes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
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
                    Navigator.pushNamed(context, plusMinusRoute);
                  }),
              SizedBox(
                height: 30,
              ),
              RaisedButton(
                  child: Text("Kalkulator"),
                  onPressed: (){
                    Navigator.pushNamed(context, kalkulatorRoute);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}



