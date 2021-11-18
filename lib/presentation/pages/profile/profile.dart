import 'package:bakht/presentation/pages/home/controllers/profile_photo_controller.dart';
import 'package:bakht/presentation/pages/home/widgets/profile_photo.dart';
import 'package:bakht/presentation/pages/profile/profile_controller.dart';
import 'package:bakht/presentation/widgets/buttons/icon_back_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  final ProfilePhotoController profilePhotoController;

  Profile({Key? key, required this.profilePhotoController}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileController? profileController;

  @override
  Widget build(BuildContext context) {
    profileController ??=
        ProfileController(context, widget.profilePhotoController);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).backgroundColor,
            ],
            tileMode: TileMode.repeated,
            end: Alignment.bottomLeft,
            begin: Alignment.topRight),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconBack(),
                  Container(
                    alignment: Alignment.bottomRight,
                    width: 200,
                    height: 150,
                    // padding: EdgeInsets.only(right: 10, left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: IconButton(
                            onPressed: profileController?.editProfilePhoto,
                            icon: Icon(
                              Icons.camera_alt,
                              size: 35,
                              color: Theme.of(context).highlightColor,
                            ),
                          ),
                        ),
                        ChangeNotifierProvider(
                          create: (context) =>
                              profileController?.profilePhotoController,
                          builder: (context, child) {
                            return ProfilePhoto();
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
