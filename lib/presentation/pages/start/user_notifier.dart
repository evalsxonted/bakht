
import 'package:bakht/core/either/either.dart';
import 'package:bakht/core/error/handle_failure.dart';
import 'package:bakht/core/platform/network_info.dart';
import 'package:bakht/core/usecase/usecase.dart';
import 'package:bakht/features/user/data/datasources/user_local_datasource.dart';
import 'package:bakht/features/user/data/datasources/user_remote_datasource.dart';
import 'package:bakht/features/user/data/impls/user_impl.dart';
import 'package:bakht/features/user/domain/entities/user.dart';
import 'package:bakht/features/user/domain/usecases/get_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';

import 'package:flutter/material.dart';

class UserNotifier extends ChangeNotifier{
  User? _user;

  User? get language => _user ;

  Future<UserNotifier> initUser(FirebaseFirestore firestore) async{
    Either result = await GetUser(userAbstraction: UserImpl(
      networkInfo: NetworkInfoImplementation(
        connectionChecker: Connectivity(),
      ),
       userLocalDatasource: UserLocalDatasourceImpl(),
      userRemoteDatasource: UserRemoteDatasourceImpl(
        firebaseFirestore: firestore
      ),
    )).call(NoParams());

    if(result.isFailed){
      HandleFailure(result.left!).saveToLocalLog();
      _user = null;
    }else{
      _user = result.right;
    }
    return this;
  }
  changeUser(User newUser){
    _user = newUser;
    notifyListeners();
  }
}