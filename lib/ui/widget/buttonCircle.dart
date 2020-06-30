import 'package:flutter/material.dart';

class ButtonCircle extends StatelessWidget {
  String text;
  Function action;

  ButtonCircle({ this.text, this.action});

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Material(
        color: Colors.blue,
        child: InkWell(
          splashColor: Colors.green,
          child: SizedBox(
            width: 56,
            height: 56,
            child:
            //Icon(Icons.menu)
            Center(child: Text(text, style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),)),
          ),
          onTap: action,
        ),
      ),
    );
  }
}
