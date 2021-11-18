import 'dart:io';

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
import 'package:firebase_auth/firebase_auth.dart' as fa;
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class UserImpl implements UserAbstraction {
  final NetworkInfo networkInfo;
  final UserLocalDatasource userLocalDatasource;
  final UserRemoteDatasource userRemoteDatasource;

  UserImpl(
      {required this.networkInfo,
      required this.userRemoteDatasource,
      required this.userLocalDatasource});

  @override
  Future<Either<User>> getUser(fa.User authUser) async {
    Either<User> userResult = Either(null, null);
    try {
      UserModel localUser = await userLocalDatasource.getUser();
      UserModel remoteUser = await userRemoteDatasource.getUser(localUser.id);
      userResult.right = remoteUser;
      remoteUser.lastLoginEpoch = DateTime.now().millisecondsSinceEpoch;
      Either<bool> updated = await updateUser(remoteUser);
      if (updated.right == true) {
        return userResult;
      } else {
        userResult.left = updated.left;
        return userResult;
      }
    } on NotFoundException {
      userResult = await addNewGuestUser(authUser);
      return userResult;
    } on ModelingException catch (e){
      userResult.left = Failure(
          "error getting user, if this error keeps showing please contact the app developer, error code 18",
          e.message);
      return userResult;
    } on UnknownException catch (e) {
      return Either(
          Failure(
              "error getting user, if this error keeps showing please contact the app developer, error code 7",
              e.message),
          null);
    } catch (e) {
      return Either(
          Failure(
              "error getting user, if this error keeps showing please contact the app developer, error code 10",
              e.toString()),
          null);
    }
  }

  @override
  Future<Either<User>> addNewGuestUser(fa.User authUser) async {
    UserModel user = UserModel.defaultGuest();
    user.authUserId = authUser.uid;
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
      return Either(
          Failure(
              "error getting user, if this error keeps showing please contact the app developer error code 1",
              e.message),
          null);
    } on FirebaseException catch (e) {
      return Either(
          Failure(
              "error getting user, if this error keeps showing please contact the app developer, error code 2",
              e.toString()),
          null);
    } on UnknownException catch (e) {
      return Either(
          Failure(
              "error getting user, if this error keeps showing please contact the app developer, error code 3",
              e.message),
          null);
    } catch (e) {
      return Either(
          Failure(
              "error getting user, if this error keeps showing please contact the app developer, error code 8",
              e.toString()),
          null);
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
      return Either(
          Failure(
              "error updating user, if this error keeps showing please contact the app developer error code 4",
              e.message),
          null);
    } on FirebaseException catch (e) {
      return Either(
          Failure(
              "error updating user, if this error keeps showing please contact the app developer, error code 5",
              e.toString()),
          null);
    } on UnknownException catch (e) {
      return Either(
          Failure(
              "error updating user, if this error keeps showing please contact the app developer, error code 6",
              e.message),
          null);
    } catch (e) {
      return Either(
          Failure(
              "error getting user, if this error keeps showing please contact the app developer, error code 9",
              e.toString()),
          null);
    }
  }

  @override
  Future<Either<File>> getProfilePhoto() async {
    Either<File> either = Either(null, null);
    try {
      either.right = await userLocalDatasource.getProfilePhoto();
    } on NotFoundException {
      try {
        File profilePhoto =
                  File((await getTemporaryDirectory()).path + "/profile/profile.png");
        await profilePhoto.create(recursive: true);
        ByteData bytes = await rootBundle.load('assets/icons/profile/profile2.png');

        await profilePhoto.writeAsBytes(
                  bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
        either.right = profilePhoto;
      } catch (e) {
        either.left = Failure(
            "error in getting profile photo, if this error keeps showing please contact the app developer, error code 16",
            e.toString() + " -- error code 16 ");
      }
    } catch (e) {
      either.left = Failure(
          "error in getting profile photo, if this error keeps showing please contact the app developer, error code 17",
          e.toString() +  " -- error code 17 ");
    }
    return either;
  }

  @override
  Future<Either<bool>> saveProfilePhoto() async {
    Either<bool> result = Either(null, null);
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if(image != null){
            if(await userLocalDatasource.setProfilePhoto(image.path)){
              result.right = true;
            }else{
              result.right = false;
            }
          }else{
            result.right = false;
          }
    } catch (e) {
      result.left = Failure("error in setting profile photo,"
          " if this error keeps showing please contact the app developer, error code 19", e.toString());
    }
    return result;
  }
}
