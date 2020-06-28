import 'dart:async';

class ValidatorInput{
  var inputAvalidator  = StreamTransformer<String, String>.fromHandlers(
      handleData: (inputA, sink){
        if (inputA.isEmpty){
          sink.addError("Input A Kosong");
        }else {
          sink.add(inputA);
        }
      }
  );

  var inputBvalidator  = StreamTransformer<String, String>.fromHandlers(
      handleData: (inputB, sink){
        if (inputB.isEmpty){
          sink.addError("Input B Kosong");
        }else {
          sink.add(inputB);
        }
      }
  );
}