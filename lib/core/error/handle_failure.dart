import 'package:bakht/core/error/failure.dart';

class HandleFailure{
  final Failure failure;
  HandleFailure(this.failure){
    print("failure occurred");
    print(failure.messageToShow);
    print(failure.messageToDev);
  }

  uploadToDev(){
    //todo
  }
  saveToLocalLog(){
    //todo
  }

}