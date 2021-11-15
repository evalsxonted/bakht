import 'package:bakht/presentation/pages/home/widgets/profile_photo.dart';
import 'package:flutter/material.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
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
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            width: 100,
            height: 100,
            child: ProfilePhoto(),
          ),
        ),
      ),
    );
  }

  Future<bool> popPage() async {
    Navigator.pop(context);
    return false;
  }
}

