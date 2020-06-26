import 'package:rxdart/rxdart.dart';

class Bloc {
  int initialCount = 0;
  BehaviorSubject<int> _subject;

  Bloc(this.initialCount){
    _subject = BehaviorSubject<int>.seeded(initialCount);
  }

  Observable<int> get counterObservable {
    return _subject.stream;
  }

  void increment() {
    initialCount++;
    _subject.sink.add(initialCount);
  }

  void decrement(){
    initialCount--;
    _subject.sink.add(initialCount);
  }

  void dispose(){
    _subject.close();
  }
}