import 'package:admin/presentation/Modules/SideBarTabs/Dashboard/components/posts_details.dart';
import 'package:admin/presentation/Shared/Components.dart';
import 'package:flutter/material.dart';

import '../Components/Header/header.dart';
import 'announcements_display.dart';

class AnnouncementPage extends StatelessWidget {
  const AnnouncementPage();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(30),
      children: [
        Header(),
        getCube(5, context),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Announcement of TaskForce",
                  style: TextStyle(fontSize: getHeight(3, context))),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add_circle_outline_rounded),
                  label: Text("Add New Announcement")),
            ),
          ],
        ),
        getCube(3, context),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: getWidth(35, context),
              child: AnnouncementDisplay(),
            ),
            getCube(3, context),
            Container(
              alignment: Alignment.topRight,
              child: PostsDetails(),
              height: getHeight(80, context),
              width: getWidth(30, context),
            )
          ],
        ),
      ],
    );
  }
}
