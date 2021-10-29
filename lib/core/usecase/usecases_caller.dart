import 'package:bakht/core/platform/network_info.dart';
import 'package:bakht/features/app/data/datasources/prefs_local_datasource.dart';
import 'package:bakht/features/app/data/impls/prefs_impl.dart';
import 'package:bakht/features/app/domain/abstractions/prefs_abstraction.dart';
import 'package:bakht/features/app/domain/usecases/get_language.dart';
import 'package:bakht/features/app/domain/usecases/get_theme.dart';
import 'package:bakht/features/user/data/datasources/user_local_datasource.dart';
import 'package:bakht/features/user/data/datasources/user_remote_datasource.dart';
import 'package:bakht/features/user/data/impls/auth_impl.dart';
import 'package:bakht/features/user/data/impls/user_impl.dart';
import 'package:bakht/features/user/domain/abstractions/auth_abstraction.dart';
import 'package:bakht/features/user/domain/abstractions/user_abstraction.dart';
import 'package:bakht/features/user/domain/usecases/auth_guest.dart';
import 'package:bakht/features/user/domain/usecases/get_user.dart';
import 'package:bakht/features/user/domain/usecases/listen_user_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';

// late final UseCaseCaller useCaseCaller;

class UseCaseCaller{
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  UseCaseCaller(this.firebaseFirestore, this.firebaseAuth);

  GetUser getUser () {
    return GetUser(userAbstraction: userImpl());
  }
  UserAbstraction userImpl(){
    return UserImpl(
      networkInfo: networkInfo(),
      userRemoteDatasource: userRemoteDatasource(),
      userLocalDatasource: userLocalDatasource(),
    );
  }
  NetworkInfo networkInfo(){
    return NetworkInfoImplementation(connectionChecker: connectionChecker());
  }
  Connectivity connectionChecker(){
    return Connectivity();
  }
  UserRemoteDatasource userRemoteDatasource(){
    return UserRemoteDatasourceImpl(firebaseFirestore: firebaseFirestore);
  }
  UserLocalDatasource userLocalDatasource(){
    return UserLocalDatasourceImpl();
  }
  AuthGuest authGuest (){
    return AuthGuest(authAbstraction: authAbstraction());
  }
  AuthAbstraction authAbstraction(){
    return AuthImpl(auth: firebaseAuth, networkInfo: networkInfo());
  }
  AuthListen authListen(){
    return AuthListen(
      authAbstraction: authAbstraction(),
    );
  }
  GetTheme getTheme(){
    return GetTheme(prefsAbstraction: prefsAbstraction());
  }
  GetLanguage getLanguage (){
    return GetLanguage(prefsAbstraction: prefsAbstraction());
  }
  PrefsAbstraction prefsAbstraction (){
    return PrefsImpl(prefsLocalDatasource: prefsLocalDatasource());
  }
  PrefsLocalDatasource prefsLocalDatasource (){
    return PrefsLocalDatasourceImpl();
  }
}
