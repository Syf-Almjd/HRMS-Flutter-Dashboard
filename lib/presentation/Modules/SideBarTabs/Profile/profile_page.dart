import 'package:admin/presentation/Modules/SideBarTabs/Profile/profile_display.dart';
import 'package:flutter/material.dart';

import '../../../Shared/Components.dart';
import '../Components/Header/header.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(30),
      children: [
        Header(tabName: "Profile"),
        getCube(5, context),
        Container(
          height: getHeight(100, context),
          width: getWidth(100, context),
          child: ProfileDisplay(),
        )
      ],
    );
  }
}
