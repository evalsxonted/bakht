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
    return Scaffold(
      body: Center(
        child: Hero(
            tag: "ProfilePhoto",
            child: ProfilePhoto(),
        ),
      ),
    );
  }

  Future<bool> popPage() async {
    Navigator.pop(context);
    return false;
  }
}

