import 'package:bakht/core/either/either.dart';
import 'package:bakht/core/error/failure.dart';
import 'package:bakht/core/platform/network_info.dart';
import 'package:bakht/features/user/domain/abstractions/auth_abstraction.dart';
import 'package:bakht/presentation/pages/error/error.dart';
import 'package:firebase_auth/firebase_auth.dart' as fa;

class AuthImpl implements AuthAbstraction{
  final fa.FirebaseAuth auth;
  final NetworkInfo networkInfo;
  AuthImpl({required this.auth, required this.networkInfo});

  @override
  Future<Either<bool>> listenToAuthChanges() async {
    try {
      auth.userChanges().listen((fa.User? user) {
            if (user == null) {
              showErrorPage(
                "the use is signed out, if this error keeps showing please contact the app developer, error code 12"
              );
            }
          });
      return Either(null, true);
    } catch (e) {
      return Either(Failure("failed in authentication, if this error keeps showing please contact the app developer, error code 11",
        e.toString(),
      ), null);
    }
  }

  @override
  Future<Either<fa.User>> registerGuestAuth() async{
    try {
      fa.UserCredential userCredential = await auth.signInAnonymously();
      return Either(null, userCredential.user);
    } catch (e) {
      return Either(Failure(
          "sign in failed, if this error keeps showing please contact the app developer, error code 14",
          e.toString()
      ), null);
    }

  }

  @override
  Future<Either<fa.User>> registerPhoneAuth() {
    // TODO: implement registerPhoneAuth
    throw UnimplementedError();
  }

  @override
  Future<Either<bool>> signOut() async {
     try {
       await auth.signOut();
       return Either(null, true);
     } catch (e) {
        return Either(Failure(
         "sign out failed, if this error keeps showing please contact the app developer, error code 13",
       e.toString()
       ), true);
     }
  }

}