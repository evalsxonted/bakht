import 'dart:io';

import 'package:bakht/core/error/exceptions.dart';
import 'package:bakht/features/user/data/models/user_model.dart';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

abstract class UserLocalDatasource {
  Future<UserModel> getUser();

  //return user document id
  Future<bool> addNewUser(UserModel user);

  Future<bool> updateUser(UserModel user);
  Future<File> getProfilePhoto();
  Future<bool> setProfilePhoto(File file);
}

class UserLocalDatasourceImpl implements UserLocalDatasource {
  @override
  Future<UserModel> getUser() async {
    Box userBox = await Hive.openBox("users");
    String? userJson = userBox.get("user");
    if (userJson == null) {
      throw NotFoundException("hive user not found");
    } else {
      try {
        return UserModel.fromJson(userJson);
      } catch (e) {
        throw ModelingException("user cant be modeled from hive. user: " +
            userJson +
            " " +
            e.toString());
      }
    }
  }

  @override
  Future<bool> addNewUser(UserModel user) async {
    try {
      Box userBox = await Hive.openBox("users");
      userBox.put("user", user.toJson());
      return true;
    } catch (e) {
      throw UnknownException({
        "type": "unknown",
        "class": "UserLocalDatasourceImpl",
        "function": "getUser",
        "date": DateTime.now().toIso8601String(),
        "exception": e.toString()
      }.toString());
    }
  }

  @override
  Future<bool> updateUser(UserModel user) async {
    try {
      Box userBox = await Hive.openBox("users");
      userBox.put(user.id, user.toJson());
      return true;
    } catch (e) {
      throw UnknownException({
        "type": "unknown",
        "class": "UserLocalDatasourceImpl",
        "function": "getUser",
        "date": DateTime.now().toIso8601String(),
        "exception": e.toString()
      }.toString());
    }
  }

  @override
  Future<File> getProfilePhoto() async {
    File profilePhoto = File((await getTemporaryDirectory()).path + "/profile/profile.png");
    if (await profilePhoto.exists()){
      return profilePhoto;
    }else {
      throw NotFoundException();
    }
  }

  @override
  Future<bool> setProfilePhoto(File file) {
    //file must be png
    // TODO: implement setProfilePhoto
    throw UnimplementedError();
  }
}
