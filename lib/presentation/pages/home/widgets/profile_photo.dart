
import 'package:bakht/presentation/pages/home/controllers/profile_photo_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePhoto extends StatefulWidget {

  const ProfilePhoto({Key? key}) : super(key: key);

  @override
  _ProfilePhotoState createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {

  Image? image;
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
          padding: EdgeInsets.all(5),
          width: 140,
          height: 180,
          color: Theme.of(context).cardColor,
          child:  Consumer<ProfilePhotoController>(
            builder: (context,ProfilePhotoController profilePhotoController, child) {


              if(profilePhotoController.imageFile == null){
                return Image.asset("assets/icons/profile/profile2.png");
              }else{
                return Image.file(
                  profilePhotoController.imageFile!,
                  fit: BoxFit.fill,
                  key: UniqueKey(),
                );
              }
              },
          )
      ),
    );
  }
}
