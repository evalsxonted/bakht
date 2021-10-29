import 'package:bakht/core/either/either.dart';
import 'package:bakht/core/error/handle_failure.dart';
import 'package:bakht/core/usecase/usecase.dart';
import 'package:bakht/core/usecase/usecases_caller.dart';
import 'package:bakht/features/user/domain/entities/user.dart';
import 'package:bakht/features/user/domain/usecases/auth_guest.dart';
import 'package:bakht/features/user/domain/usecases/get_user.dart';
import 'package:bakht/features/user/domain/usecases/listen_user_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as fa;

import 'package:flutter/material.dart';

class UserNotifier extends ChangeNotifier {

  User? _user;
  User? get language => _user;
  Future<UserNotifier> initUser(fa.FirebaseAuth auth, UseCaseCaller useCaseCaller) async {
    GetUser getUser = useCaseCaller.getUser();
    AuthGuest authGuest = useCaseCaller.authGuest();
    AuthListen authListen =useCaseCaller.authListen();
    //
    fa.User? authUser = auth.currentUser;
    if (authUser == null) {
      Either<fa.User> authResult = await authGuest(NoParams());
      if (authResult.isFailed) {
        HandleFailure(authResult.left!).saveToLocalLog();
        HandleFailure(authResult.left!).showErrorPage();
      } else {
        authUser = authResult.right;
      }
    }
    //
    Either<User> userResult = await getUser(authUser!);
    if (userResult.isFailed) {
      HandleFailure(userResult.left!).saveToLocalLog();
      HandleFailure(userResult.left!).showErrorPage();
    } else {
      _user = userResult.right;
    }
    authListen(NoParams());
    return this;
  }

  changeUser(User newUser) {
    _user = newUser;
    notifyListeners();
  }

}
