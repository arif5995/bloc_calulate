import 'dart:async';

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
}

class KalkulatorBloc {
  BehaviorSubject<KalkulatorEvent> _eventController = BehaviorSubject<KalkulatorEvent>();
  StreamSink<KalkulatorEvent> get eventSink => _eventController.sink;

  BehaviorSubject<KalkulatorState> _stateController = BehaviorSubject<KalkulatorState>();
  StreamSink<KalkulatorState> get _stateSink => _stateController.sink;
  Observable<KalkulatorState> get stateStream => _stateController.stream;

  void _mapEventToState(KalkulatorEvent kalkulatorEvent){
    int results = 0;
    String inputA = "Input A Kosong";
    String inputB = "Input B Kosong";
    if (kalkulatorEvent.numberA == null){
        _stateSink.add(KalkulatoorFailed(inputA));
    } else if (kalkulatorEvent.numberB == null){
        _stateSink.add(KalkulatoorFailed(inputB));
    }else{
      switch (kalkulatorEvent.operation) {
        case Operation.tambah:
          results = kalkulatorEvent.numberA + kalkulatorEvent.numberB;
          _stateSink.add(KalkulatorSukses(results));
          print(results);
          print("Inputan A : ${kalkulatorEvent.numberA}");
          print("Inputan B : ${kalkulatorEvent.numberB}");
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