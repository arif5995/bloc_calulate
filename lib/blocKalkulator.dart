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

  StreamController<KalkulatorSukses> _stateController = StreamController<KalkulatorSukses>();
  StreamSink<KalkulatorSukses> get _stateSink => _stateController.sink;
  Stream get stateStream => _stateController.stream;

  void _mapEventToState(KalkulatorEvent kalkulatorEvent){
    int results = 0;
    switch (kalkulatorEvent.operation) {
      case Operation.tambah:
        results = kalkulatorEvent.numberA + kalkulatorEvent.numberB;
        _stateSink.add(KalkulatorSukses(results));
        break;
      case Operation.kurang:
        results = kalkulatorEvent.numberA - kalkulatorEvent.numberB;
        _stateSink.add(KalkulatorSukses(results));
        break;
      case Operation.kali:
        results = kalkulatorEvent.numberA * kalkulatorEvent.numberB;
        _stateSink.add(KalkulatorSukses(results));
        break;
      case Operation.bagi:
        results = kalkulatorEvent.numberA ~/ kalkulatorEvent.numberB;
        _stateSink.add(KalkulatorSukses(results));
        break;
      default:
        print("Invalid choice");
        break;
    }
  }

  KalkulatorBloc(){
    _eventController.stream.listen(_mapEventToState);
  }

  void dispose(){
    _eventController.close();
    _stateController.close();
  }
}