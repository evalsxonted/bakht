import 'dart:io';

import 'package:bakht/core/either/either.dart';
import 'package:bakht/core/error/handle_failure.dart';
import 'package:bakht/core/usecase/usecase.dart';
import 'package:bakht/core/usecase/usecases_caller.dart';
import 'package:bakht/features/user/domain/usecases/get_profile_photo.dart';
import 'package:flutter/cupertino.dart';

class ProfilePhotoController extends ChangeNotifier{
  GetProfilePhoto _getProfilePhoto = UseCaseCaller.instance!.getProfilePhoto();
  File? imageFile;
  ProfilePhotoController() {
    getImage();
  }
  void getImage() async {
    Either<File> result = await _getProfilePhoto(NoParams());
    if (result.isFailed) {
      HandleFailure(result.left!).uploadToDev();
    } else {
      imageFile = result.right!;
    }
    imageCache?.clear();
    imageCache?.clearLiveImages();
    notifyListeners();
  }


  @override
  // ignore: must_call_super
  dispose() async {}
  manuallyDispose(){
    super.dispose();
  }
}
