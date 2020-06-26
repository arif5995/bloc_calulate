import 'dart:async';

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
  StreamController<KalkulatorEvent> _eventController = StreamController<KalkulatorEvent>();
  StreamSink<KalkulatorEvent> get eventSink => _eventController.sink;

  StreamController<KalkulatorState> _stateController = StreamController<KalkulatorState>();
  StreamSink<KalkulatorState> get _stateSink => _stateController.sink;
  Stream<KalkulatorState> get stateStream => _stateController.stream;

  void _mapEventToState(KalkulatorEvent kalkulatorEvent){
    int results = 0;
    String inputA = "Input A Kosong";
    String inputB = "Input B Kosong";
    switch (kalkulatorEvent.operation) {
      case Operation.tambah:
        if (kalkulatorEvent.numberA == null){
          _stateSink.add(KalkulatoorFailed(inputA));
        } else if (kalkulatorEvent.numberB == null){
          _stateSink.add(KalkulatoorFailed(inputB));
        }else{
          results = kalkulatorEvent.numberA + kalkulatorEvent.numberB;
          _stateSink.add(KalkulatorSukses(results));
        }
//        results = kalkulatorEvent.numberA + kalkulatorEvent.numberB;
//        _stateSink.add(KalkulatorSukses(results));
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