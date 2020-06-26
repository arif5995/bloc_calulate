import 'package:bloccalulate/bloc/blocKalkulator.dart';
import 'package:flutter/material.dart';

class KalkulatorPage extends StatefulWidget {
  @override
  _KalkulatorPageState createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  KalkulatorBloc kalkulatorBloc = KalkulatorBloc();
  bool _validate = false;
  final TextEditingController _controllerNumberA = TextEditingController();
  final TextEditingController _controllerNumberB = TextEditingController();

  void calculate(Operation operation){
    if (_controllerNumberA.text.isEmpty && _controllerNumberB.text.isEmpty){
      kalkulatorBloc.add(KalkulatorEvent(operation, null, null));
    } else if (_controllerNumberA.text.isEmpty){
      int numberB =  int.parse(_controllerNumberB.text.toString());
      kalkulatorBloc.add(KalkulatorEvent(operation, null, numberB));
    } else if (_controllerNumberB.text.isEmpty){
      int numberA =  int.parse(_controllerNumberA.text.toString());
      kalkulatorBloc.add(KalkulatorEvent(operation, numberA, null));
    }else {
      int numberA = int.parse(_controllerNumberA.text.toString());
      int numberB = int.parse(_controllerNumberB.text.toString());
      print("Data a: ${numberA.toString()}");
      print("Data b: ${numberB.toString()}");
      kalkulatorBloc.add(KalkulatorEvent(operation, numberA, numberB));
    }
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
                    errorText: _validate ? "Number A Kosoong" : null
                  ),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _controllerNumberB,
                  decoration: InputDecoration(
                    labelText: 'Number B',
                      errorText: _validate ? "Number B Kosoong" : null
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
                StreamBuilder<KalkulatorState>(
                    stream: kalkulatorBloc.stateStream,
                    builder: (context, snapshot){
                      if(snapshot.hasData){
                        if (snapshot.data is KalkulatorSukses) {
                          final data = snapshot.data as KalkulatorSukses;
                          return Column(
                            children: <Widget>[
                              Text("Hasil : ${data.result}"),
                              Text("Input A: ${_controllerNumberA.text}"),
                              Text("Input B: ${_controllerNumberB.text}")
                            ],
                          );
                        }else if (snapshot.data is KalkulatoorFailed) {
                          final errors = snapshot.data as KalkulatoorFailed;
                          return Text(errors.error);
                        }else {
                          return Container();
                        }
                      }else {
                        return Container();
                      }
                    },)
//               StreamBuilder(
//                   stream: kalkulatorBloc.stateStream,
//                   builder: (context, snapshot ){
//                     if(snapshot.hasData){
//                       return Text("Hasil : ${snapshot.data.result}");
//                     } else {
//                       return Text("");
//                     }
//                   })
              ],
            ),
          )),
    );
  }
}
