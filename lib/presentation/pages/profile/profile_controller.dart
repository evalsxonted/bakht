import 'package:bakht/core/either/either.dart';
import 'package:bakht/core/error/handle_failure.dart';
import 'package:bakht/core/usecase/usecase.dart';
import 'package:bakht/core/usecase/usecases_caller.dart';
import 'package:bakht/features/user/domain/usecases/save_profile_photo.dart';
import 'package:bakht/presentation/pages/home/controllers/profile_photo_controller.dart';
import 'package:bakht/presentation/pages/start/user_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileController {
  final SaveProfilePhoto saveProfilePhoto =
      UseCaseCaller.instance!.saveProfilePhoto();
  final BuildContext context;
  late final UserNotifier userNotifier ;
  late final ProfilePhotoController profilePhotoController;
  ProfileController(this.context, this.profilePhotoController){
    userNotifier = Provider.of<UserNotifier>(context, listen: false);
  }

  editProfilePhoto() async {
    Either<bool> result = await saveProfilePhoto(NoParams());
    if (result.isFailed) {
      HandleFailure(result.left!).saveToLocalLog();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error in image saving")));
    } else {
      if (result.right == true) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Saved successfully")));
        profilePhotoController.getImage();

      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("The image wasn't saved")));
      }
    }
  }

}
