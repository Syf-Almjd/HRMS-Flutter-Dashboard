import 'package:admin/domain/Models/eLeaveModel.dart';
import 'package:flutter/material.dart';

import '../../../../../../config/utils/styles/app_colors.dart';
import '../../../../../Shared/Components.dart';
import '../../../../../Shared/MapsLauncher.dart';
import '../../../../../Shared/WidgetBuilders.dart';

class EleaveHistoryCard extends StatelessWidget {
  final EleaveModel eleaveModel;

  const EleaveHistoryCard({required this.eleaveModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: getHeight(100, context),
        width: getWidth(17, context),
        child: Wrap(
          // alignment: WrapAlignment.center,
          children: [
            SizedBox(
              height: getHeight(25, context),
              width: getWidth(25, context),
              child: previewImage(
                editable: false,
                context: context,
                fileUser: eleaveModel.userPhoto,
              ),
            ),
            getCube(2, context),
            Container(
              height: getHeight(60, context),
              width: getWidth(20, context),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                children: [
                  ListTile(
                    leading: Icon(Icons.info_outlined),
                    title: Text('Date Attended'),
                    subtitle: Text(eleaveModel.requestInfo),
                  ),
                  ListTile(
                    leading: Icon(Icons.date_range_outlined),
                    title: Text('Date Attended'),
                    subtitle: Text(getDateTimeToDay(eleaveModel.dateTime)),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.person_2_outlined),
                    title: Text('User ID'),
                    subtitle: Text(eleaveModel.userUID),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.location_city),
                    title: Text('User City'),
                    subtitle: Text(eleaveModel.userCity),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('User Location Latitude'),
                    subtitle: Text(eleaveModel.userLocationLatitude.toString()),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('User Location Longitude'),
                    subtitle:
                        Text(eleaveModel.userLocationLongitude.toString()),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text('User Attendance Date'),
                    subtitle: Text(eleaveModel.dateTime.toString()),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton.icon(
                      onPressed: () => MapsLauncher.launchCoordinates(
                          eleaveModel.userLocationLatitude,
                          eleaveModel.userLocationLongitude),
                      icon: Icon(Icons.map),
                      label: Text('Show in Maps'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
