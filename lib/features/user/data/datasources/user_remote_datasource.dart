import 'package:bakht/core/error/exceptions.dart';
import 'package:bakht/features/user/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class UserRemoteDatasource {
  Future<UserModel> getUser(String id);

  //return user document id
  Future<String> addNewUser(UserModel user);

  Future<bool> updateUser(UserModel user);
}

class UserRemoteDatasourceImpl implements UserRemoteDatasource {
  final FirebaseFirestore firebaseFirestore;

  UserRemoteDatasourceImpl({required this.firebaseFirestore});

  @override
  Future<UserModel> getUser(String id) async {
    try {
      DocumentSnapshot documentSnapshot =
          await firebaseFirestore.collection("users").doc(id).get();
      if (documentSnapshot.exists) {
        try {
          return UserModel.fromFirestoreDoc(documentSnapshot);
        } catch (e) {
          throw ModelingException(
              "user cant be modeled from firestore. user: " +
                  documentSnapshot.data().toString() +
                  " " +
                  e.toString());
        }
      } else {
        throw NotFoundException(
            "user not found in firestore. user id: " + id);
      }
    } on FirebaseException catch (e) {
      throw e;
    }
    // throw UnknownException({
    //   "type": "unknown",
    //   "class": "UserRemoteDatasourceImpl",
    //   "function": "getUser",
    //   "date": DateTime.now().toIso8601String(),
    //   "exception": e.toString()
    // }.toString());
  }

  @override
  Future<String> addNewUser(UserModel user) async {
    user.id = firebaseFirestore.collection("users").doc().id;
    try {
      Map<String, dynamic> userData;
      try {
        userData = user.toFirestoreDocumentData();
      } catch (e) {
        throw ModelingException(
            "user cant model to firestore map. user: " + user.toString());
      }

      await firebaseFirestore.collection("users").doc(user.id).set(userData);
      return user.id;
    } on FirebaseException catch (e) {
      throw e;
    }
    // throw UnknownException({
    //   "type": "unknown",
    //   "class": "UserRemoteDatasourceImpl",
    //   "function": "setUser",
    //   "date": DateTime.now().toIso8601String(),
    //   "exception": e.toString()
    // }.toString());
  }

  @override
  Future<bool> updateUser(UserModel user) async {
    try {
      Map<String, dynamic> userData;
      try {
        userData = user.toFirestoreDocumentData();
      } catch (e) {
        throw ModelingException(
            "user cant model to firestore map. user: " + user.toString());
      }
      await firebaseFirestore.collection("users").doc(user.id).update(userData);
      return true;
    } on FirebaseException catch (e) {
      throw e;
    }
    // throw UnknownException({
    //   "type": "unknown",
    //   "class": "UserRemoteDatasourceImpl",
    //   "function": "updateUser",
    //   "date": DateTime.now().toIso8601String(),
    //   "exception": e.toString()
    //
    // }.toString());
  }
}
