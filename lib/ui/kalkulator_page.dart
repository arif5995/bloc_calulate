import 'package:bloccalulate/blocKalkulator.dart';
import 'package:flutter/material.dart';

class KalkulatorPage extends StatefulWidget {
  @override
  _KalkulatorPageState createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  KalkulatorBloc kalkulatorBloc = KalkulatorBloc();
  final TextEditingController _controllerNumberA = TextEditingController();
  final TextEditingController _controllerNumberB = TextEditingController();

  void calculate(Operation operation){
    int numberA =  int.parse(_controllerNumberA.text.toString());
    int numberB =  int.parse(_controllerNumberA.text.toString());
    kalkulatorBloc.eventSink.add(KalkulatorEvent(operation, numberA, numberB));
  }

  @override
  void dispose() {
    kalkulatorBloc.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Kalkulator bloc'),
      ),
      body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  controller: _controllerNumberA,
                  decoration: InputDecoration(
                    labelText: 'Number A',
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _controllerNumberB,
                  decoration: InputDecoration(
                    labelText: 'Number B',
                  ),
                  keyboardType: TextInputType.number,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                          child: Text("+"),
                          onPressed: () {
                            calculate(Operation.tambah);
                          }),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: RaisedButton(
                          child: Text("-"),
                          onPressed: () {
                            calculate(Operation.kurang);
                          }),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: RaisedButton(
                          child: Text(":"),
                          onPressed: () {
                            calculate(Operation.bagi);
                          }),
                    ),
                    SizedBox(width: 8.0),
                    Expanded(
                      child: RaisedButton(
                          child: Text("x"),
                          onPressed: () {
                            calculate(Operation.kali);
                          }),
                    ),
                  ],
                ),
                SizedBox(width: 8.0),
                StreamBuilder(
                    stream: kalkulatorBloc.stateStream,
                    builder: (context, state){
                      if(state is KalkulatorSukses){
                        return Text("Hasil : ${state.data}");
                      }else if (state is KalkulatoorFailed){
                        return Text("Error : ${state.error}");
                      } else {
                        return Text("");
                      }
                    })
              ],
            ),
          )),
    );
  }
}
