import 'package:bloccalulate/bloc/blocKalkulator.dart';
import 'package:bloccalulate/ui/widget/buttonCircle.dart';
import 'package:bloccalulate/ui/widget/inputText.dart';
import 'package:bloccalulate/ui/widget/outputText.dart';
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
    } else {
      int numberA = int.parse(_controllerNumberA.text.toString());
      int numberB = int.parse(_controllerNumberB.text.toString());
      print("Data a: ${numberA.toString()}");
      print("Data b: ${numberB.toString()}");
      kalkulatorBloc.add(KalkulatorEvent(operation, numberA, numberB));
    }
  }

  final _formKey = GlobalKey<FormState>();

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
      body: Form(
        key: _formKey,
        child: Container(
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: InputText(
                      controller: _controllerNumberA,
                      hintText: "input number A",
                      validator: (String val){
                        if (val.isEmpty){
                          return "Input number A kosong";
                        }else{
                          return null;
                        }
                      },
                    )
                  ),
                  SizedBox(width: 20,),
                  Expanded(
                    child: InputText(
                      controller: _controllerNumberB,
                      hintText: "input number B",
                      validator: (String val){
                        if (val.isEmpty){
                          return "Input number B kosong" ;
                        }else{
                          return null;
                        }
                      },
                    )
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: StreamBuilder<KalkulatorState>(
                  stream: kalkulatorBloc.stateStream,
                  builder: (context, snapshot){
                    if(snapshot.hasData){
                      if (snapshot.data is KalkulatorSukses) {
                        final data = snapshot.data as KalkulatorSukses;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Hasil", style: TextStyle(fontSize: 15),),
                            OutputText(
                              output: data.result.toString(),
                            )
                          ],
                        );
                      }else if (snapshot.data is KalkulatoorFailed) {
                        final errors = snapshot.data as KalkulatoorFailed;
                        return Text(errors.error, style: TextStyle(color: Colors.red, fontSize: 12),);
                      }else {
                        return Container();
                      }
                    }else {
                      return Container();
                    }
                  },),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ButtonCircle(
                    text: "+",
                    action: (){
                      if(_formKey.currentState.validate()){
                        _formKey.currentState.save();
                        calculate(Operation.tambah);
                      }
                    },
                  ),
                  SizedBox(width: 8.0),
                  ButtonCircle(
                    text: "-",
                    action: (){
                      if(_formKey.currentState.validate()){
                        _formKey.currentState.save();
                        calculate(Operation.kurang);
                      }
                    },
                  ),
                  SizedBox(width: 8.0),
                  ButtonCircle(
                    text: "x",
                    action: (){
                      if(_formKey.currentState.validate()){
                        _formKey.currentState.save();
                        calculate(Operation.kali);
                      }
                    },
                  ),
                  SizedBox(width: 8.0),
                  ButtonCircle(
                    text: ":",
                    action: (){
                      if(_formKey.currentState.validate()){
                        _formKey.currentState.save();
                        calculate(Operation.bagi);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}