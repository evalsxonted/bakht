import 'package:bakht/presentation/pages/home/controllers/profile_photo_controller.dart';
import 'package:bakht/presentation/pages/profile/profile.dart';
import 'package:bakht/presentation/widgets/clickables/clickable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_route/widget_route.dart';

class EditProfile extends StatelessWidget {
  final widgetKey = LabeledGlobalKey("edit profile");
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor.withAlpha(255),
      padding: EdgeInsets.only(left: 30, right: 30),
      child: ClickableText(
        key: widgetKey,
        text: "edit profile",
        function: () {
          ProfilePhotoController profilePhotoController = Provider.of<ProfilePhotoController>(context, listen: false);
          LaunchFromWidgetRoute route = LaunchFromWidgetRoute(
            widgetKey: widgetKey,
            page: Profile(
              profilePhotoController: profilePhotoController,
            ),
          );
          Navigator.of(context).push(route());
        },
        color: Theme.of(context).highlightColor,
      ),
    );
  }
}
