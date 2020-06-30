import 'package:bloccalulate/routes.dart';
import 'package:bloccalulate/ui/widget/buttonSquare.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Button1(
                  name: "+ dan -",
                  action: (){
                    Navigator.pushNamed(context, plusMinusRoute);
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Button1(
                  name: "KALKULATOR",
                  action: (){
                    Navigator.pushNamed(context, kalkulatorRoute);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



