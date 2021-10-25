import 'package:bakht/core/either/either.dart';
import 'package:bakht/core/error/exceptions.dart';
import 'package:bakht/core/error/failure.dart';
import 'package:bakht/core/platform/network_info.dart';
import 'package:bakht/features/user/data/datasources/user_local_datasource.dart';
import 'package:bakht/features/user/data/datasources/user_remote_datasource.dart';
import 'package:bakht/features/user/data/models/user_model.dart';
import 'package:bakht/features/user/domain/abstractions/user_abstraction.dart';
import 'package:bakht/features/user/domain/entities/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserImpl implements UserAbstraction {
  final NetworkInfo networkInfo;
  final UserLocalDatasource userLocalDatasource;
  final UserRemoteDatasource userRemoteDatasource;

  UserImpl({required this.networkInfo,
    required this.userRemoteDatasource,
    required this.userLocalDatasource});

  @override
  Future<Either<User>> getUser() async {
    Either<User> userResult = Either(null, null);
    try {
      UserModel localUser = await userLocalDatasource.getUser();
      localUser.lastLoginEpoch = DateTime.now().millisecondsSinceEpoch;
      userResult.right = localUser;
      Either<bool> updated= await updateUser(localUser);
      if(updated.right == true){
        return userResult;
      }else{
        userResult.left = updated.left;
        return userResult;
      }
    } on HiveNotFoundException {
      userResult = await addNewGuestUser();
      return userResult;
    } on UnknownException catch(e) {
      return Either(Failure(
          "error getting user, if this error keeps showing please contact the app developer, error code 7",
          e.message), null);
    } catch (e){
      return Either(Failure(
          "error getting user, if this error keeps showing please contact the app developer, error code 10",
          e.toString()), null);
    }
  }
  @override
  Future<Either<User>> addNewGuestUser() async {
    UserModel user = UserModel.defaultGuest();
    try {
      if (await networkInfo.isConnected) {
        String remoteUserId = await userRemoteDatasource.addNewUser(user);
        user.id = remoteUserId;
        await userLocalDatasource.addNewUser(user);
        return Either(null, user);
      } else {
        return Either(Failure("no internet connection", null), null);
      }
    } on ModelingException catch (e) {
      return Either(Failure(
          "error getting user, if this error keeps showing please contact the app developer error code 1",
          e.message), null);
    } on FirebaseException catch (e) {
      return Either(Failure(
          "error getting user, if this error keeps showing please contact the app developer, error code 2",
          e.toString()), null);
    } on UnknownException catch (e) {
      return Either(Failure(
          "error getting user, if this error keeps showing please contact the app developer, error code 3",
          e.message), null);
    } catch (e){
      return Either(Failure(
          "error getting user, if this error keeps showing please contact the app developer, error code 8",
          e.toString()), null);
    }
  }


  @override
  Future<Either<bool>> updateUser(User user) async {
    try {
      if (await networkInfo.isConnected) {
        await userRemoteDatasource.updateUser(user as UserModel);
        return Either(null, true);
      } else {
        return Either(null, false);
      }
    } on ModelingException catch (e) {
      return Either(Failure(
          "error updating user, if this error keeps showing please contact the app developer error code 4",
          e.message), null);
    } on FirebaseException catch (e) {
      return Either(Failure(
          "error updating user, if this error keeps showing please contact the app developer, error code 5",
          e.toString()), null);
    } on UnknownException catch (e) {
      return Either(Failure(
          "error updating user, if this error keeps showing please contact the app developer, error code 6",
          e.message), null);
    } catch (e){
      return Either(Failure(
          "error getting user, if this error keeps showing please contact the app developer, error code 9",
          e.toString()), null);
    }
  }
}
