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
import 'package:bakht/features/user/domain/usecases/get_profile_photo.dart';
import 'package:bakht/features/user/domain/usecases/get_user.dart';
import 'package:bakht/features/user/domain/usecases/listen_user_auth.dart';
import 'package:bakht/features/user/domain/usecases/save_profile_photo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';

// late final UseCaseCaller useCaseCaller;

class UseCaseCaller{
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;
  static UseCaseCaller? instance ;
  UseCaseCaller({required this.firebaseFirestore,required this.firebaseAuth}){
    instance = this;
  }

  GetUser getUser () {
    return GetUser(userAbstraction: _userImpl());
  }
  UserAbstraction _userImpl(){
    return UserImpl(
      networkInfo: _networkInfo(),
      userRemoteDatasource: _userRemoteDatasource(),
      userLocalDatasource: _userLocalDatasource(),
    );
  }
  NetworkInfo _networkInfo(){
    return NetworkInfoImplementation(connectionChecker: _connectionChecker());
  }
  Connectivity _connectionChecker(){
    return Connectivity();
  }
  UserRemoteDatasource _userRemoteDatasource(){
    return UserRemoteDatasourceImpl(firebaseFirestore: firebaseFirestore);
  }
  UserLocalDatasource _userLocalDatasource(){
    return UserLocalDatasourceImpl();
  }
  AuthGuest authGuest (){
    return AuthGuest(authAbstraction: _authAbstraction());
  }
  AuthAbstraction _authAbstraction(){
    return AuthImpl(auth: firebaseAuth, networkInfo: _networkInfo());
  }
  AuthListen authListen(){
    return AuthListen(
      authAbstraction: _authAbstraction(),
    );
  }
  GetTheme getTheme(){
    return GetTheme(prefsAbstraction: _prefsAbstraction());
  }
  GetLanguage getLanguage (){
    return GetLanguage(prefsAbstraction: _prefsAbstraction());
  }
  PrefsAbstraction _prefsAbstraction (){
    return PrefsImpl(prefsLocalDatasource: _prefsLocalDatasource());
  }
  PrefsLocalDatasource _prefsLocalDatasource (){
    return PrefsLocalDatasourceImpl();
  }

  GetProfilePhoto getProfilePhoto(){
    return GetProfilePhoto(userAbstraction: _userImpl());
  }
  SaveProfilePhoto saveProfilePhoto(){
    return SaveProfilePhoto(userAbstraction: _userImpl());
  }
}
