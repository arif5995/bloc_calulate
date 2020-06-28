import 'dart:async';

import 'package:bloccalulate/validator/validator_input.dart';
import 'package:rxdart/rxdart.dart';

enum Operation{
  tambah,
  kurang,
  kali,
  bagi
}

abstract class KalkulatorState {}
class KalkulatorSukses extends KalkulatorState {
  final int result;
  KalkulatorSukses(this.result);
}

class KalkulatoorFailed extends KalkulatorState {
  final String error;

  KalkulatoorFailed(this.error);
}

class KalkulatorEvent{
  final Operation operation;
  final int numberA;
  final int numberB;

  KalkulatorEvent(this.operation, this.numberA, this.numberB);
  //KalkulatorEvent(this.operation);
}

class KalkulatorBloc extends Object with ValidatorInput {
  final _inputA = StreamController<String>();
  final _inputB = StreamController<String>();

  BehaviorSubject<KalkulatorEvent> _eventController = BehaviorSubject<KalkulatorEvent>();
  StreamSink<KalkulatorEvent> get eventSink => _eventController.sink;

  BehaviorSubject<KalkulatorState> _stateController = BehaviorSubject<KalkulatorState>();
  StreamSink<KalkulatorState> get _stateSink => _stateController.sink;
  Stream<KalkulatorState> get stateStream => _stateController.stream;

  //Validasi Input
//  Function(String) get inputA =>_inputA.sink.add;
//  Function(String) get inputB =>_inputB.sink.add;
//  Stream<String> get InputA => _inputA.stream.transform(inputAvalidator);
//  Stream<String> get InputB => _inputB.stream.transform(inputBvalidator);

  //Button
//  Stream<bool> get submitCheck => Observable.combineLatest2(InputA, InputB, (a, b) => true);

  void _mapEventToState(KalkulatorEvent kalkulatorEvent){
    int results = 0;
//    int A = int.parse(_inputA.toString());
//    int B = int.parse(_inputB.toString());
    if (kalkulatorEvent.numberA == null){
      _stateSink.add(KalkulatoorFailed("Input A Kosong"));
    }else if (kalkulatorEvent.numberB == null){
      _stateSink.add(KalkulatoorFailed("Input B Kosong"));
    }else{
      switch (kalkulatorEvent.operation) {
        case Operation.tambah:
          results = kalkulatorEvent.numberA + kalkulatorEvent.numberB;
          print(results);
          print("Inputan A : ${kalkulatorEvent.numberA}");
          print("Inputan B : ${kalkulatorEvent.numberB}");
          _stateSink.add(KalkulatorSukses(results));
          break;
        case Operation.kurang:
          results = kalkulatorEvent.numberA - kalkulatorEvent.numberB;
          _stateSink.add(KalkulatorSukses(results));
          print(results);
          break;
        case Operation.kali:
          results = kalkulatorEvent.numberA * kalkulatorEvent.numberB;
          _stateSink.add(KalkulatorSukses(results));
          print(results);
          break;
        case Operation.bagi:
          results = kalkulatorEvent.numberA ~/ kalkulatorEvent.numberB;
          _stateSink.add(KalkulatorSukses(results));
          print(results);
          break;
        default:
          print("Invalid choice");
          break;
      }
    }
  }

  KalkulatorBloc(){
    _eventController.stream.listen(_mapEventToState);
  }

  void add(KalkulatorEvent event){
    eventSink.add(event);
  }


  void dispose(){
    _eventController.close();
    _stateController.close();
  }
}