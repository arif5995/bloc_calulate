import 'package:bloccalulate/bloc/blocKalkulator.dart';
import 'package:bloccalulate/ui/widget/buttonCircle.dart';
import 'package:bloccalulate/ui/widget/outputText.dart';
import 'package:flutter/material.dart';

class KalkulatorPage extends StatefulWidget {
  @override
  _KalkulatorPageState createState() => _KalkulatorPageState();
}

class _KalkulatorPageState extends State<KalkulatorPage> {
  KalkulatorBloc kalkulatorBloc = KalkulatorBloc();
  bool _validate = false;
  bool _Rubah = false;
  bool _tambah = true;
  final TextEditingController _controllerNumberD = TextEditingController();
  final TextEditingController _controllerNumberC = TextEditingController();
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
    } else {
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
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StreamBuilder<KalkulatorState>(
                stream: kalkulatorBloc.stateStream,
                builder: (context, snapshot) {
                  return TextField(
                    controller: _controllerNumberA,
                    decoration: InputDecoration(
                        labelText: 'Number A',
                        errorText: snapshot.error
                    ),
                    keyboardType: TextInputType.number,
                  );
                }
            ),
            SizedBox(height: 20,),
            StreamBuilder<KalkulatorState>(
                stream: kalkulatorBloc.stateStream,
                builder: (context, snapshot) {
                  return TextField(
                    controller: _controllerNumberB,
                    decoration: InputDecoration(
                        labelText: 'Number B',
                        errorText: snapshot.error
                    ),
                    keyboardType: TextInputType.number,
                  );
                }
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                ButtonCircle(
                  text: "+",
                  action: (){
                    calculate(Operation.tambah);
                  },
                ),
                SizedBox(width: 8.0),
                ButtonCircle(
                  text: "-",
                  action: (){
                    calculate(Operation.tambah);
                  },
                ),
                SizedBox(width: 8.0),
                ButtonCircle(
                  text: "x",
                  action: (){
                    calculate(Operation.tambah);
                  },
                ),
                SizedBox(width: 8.0),
                ButtonCircle(
                  text: ":",
                  action: (){
                    calculate(Operation.tambah);
                  },
                ),
              ],
            ),
            StreamBuilder<KalkulatorState>(
                stream: kalkulatorBloc.stateStream,
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    if (snapshot.data is KalkulatorSukses) {
                      final data = snapshot.data as KalkulatorSukses;
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Hasil", style: TextStyle(fontSize: 20),),
                            OutputText(
                              output: data.result.toString(),
                            )
                          ],
                        ),
                      );
                    }else if (snapshot.data is KalkulatoorFailed) {
                      final errors = snapshot.data as KalkulatoorFailed;
                      return OutputText(
                          output: errors.error.toString(),
                      );
                    }else {
                      return Container();
                    }
                  }else {
                  return Container();
                }
              },)
          ],
        ),
      ),
    );
  }
}