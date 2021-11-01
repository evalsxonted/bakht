import 'dart:io';

import 'package:bakht/core/either/either.dart';
import 'package:bakht/core/error/handle_failure.dart';
import 'package:bakht/core/usecase/usecase.dart';
import 'package:bakht/core/usecase/usecases_caller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePhoto extends StatefulWidget {
  @override
  _ProfilePhotoState createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
          padding: EdgeInsets.all(5),
          width: 140,
          height: 180,
          color: Theme.of(context).cardColor,
          child: Consumer2<FirebaseFirestore, FirebaseAuth>(
            builder: (context, firestore, auth, child) {
              return FutureBuilder(
                initialData: null,
                future: UseCaseCaller(
                        firebaseFirestore: firestore, firebaseAuth: auth)
                    .getProfilePhoto()
                    .call(NoParams()),
                builder: (context, AsyncSnapshot<Either<File>?> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isFailed) {
                      HandleFailure(snapshot.data!.left!).uploadToDev();
                      return Image.asset("assets/icons/profile/profile2.png");
                    } else {
                      return Image.file(snapshot.data!.right!);
                    }
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColorLight,
                      ),
                    );
                  }
                },
              );
            },
          )),
    );
  }
}
