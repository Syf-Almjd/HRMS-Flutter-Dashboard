import 'package:admin/presentation/Cubits/navigation_cubit/navi_cubit.dart';
import 'package:admin/presentation/Modules/SideBarTabs/Dashboard/components/posts_details.dart';
import 'package:admin/presentation/Modules/SideBarTabs/Events/Screens/add_event_screen.dart';
import 'package:admin/presentation/Shared/Components.dart';
import 'package:flutter/material.dart';

import '../Components/Header/header.dart';
import 'events_display.dart';

class EventsPage extends StatelessWidget {
  const EventsPage();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(30),
      children: [
        Header(tabName: "Events"),
        getCube(5, context),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Events of TaskForce",
                  style: TextStyle(fontSize: getHeight(3, context))),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextButton.icon(
                  onPressed: () {
                    NaviCubit.get(context).navigate(context, AddEventScreen());
                  },
                  icon: Icon(Icons.add_circle_outline_rounded),
                  label: Text("Add New Event")),
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
              child: EventsDisplay(),
            ),
            getCube(3, context),
            Align(
                alignment: Alignment.topRight,
                child: Container(
                    width: getWidth(28, context), child: PostsDetails()))
          ],
        ),
      ],
    );
  }
}
