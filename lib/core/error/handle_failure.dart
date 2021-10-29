import 'package:bakht/core/error/failure.dart';
import 'package:bakht/presentation/pages/error/error.dart';
import 'package:flutter/material.dart';

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
  showErrorPage(){
    runApp(ErrorPage(messageToShow: failure.messageToShow,));
  }
}