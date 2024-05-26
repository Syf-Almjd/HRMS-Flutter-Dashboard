import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../../../../config/utils/styles/app_colors.dart';
import '../../../../../../domain/Models/attendanceModel.dart';
import '../../../../../Shared/CachedImage.dart';
import '../../../../../Shared/Components.dart';
import '../../../../../Shared/MapsLauncher.dart';

class AttendanceHistoryCard extends StatelessWidget {
  final AttendanceModel attendanceRecord;

  const AttendanceHistoryCard({required this.attendanceRecord});

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
                child: Image(
                  image: CacheMemoryImageProvider(attendanceRecord.dateTime,
                      base64Decode(attendanceRecord.userPhoto)),
                )),
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
                    leading: Icon(Icons.date_range_outlined),
                    title: Text('Date Check In'),
                    subtitle: Text(getDateTimeToDay(attendanceRecord.dateTime)),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.security_update_good_rounded),
                    title: Text('Date Check Out'),
                    subtitle:
                        Text(getDateTimeToDay(attendanceRecord.checkOutTime)),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.person_2_outlined),
                    title: Text('User ID'),
                    subtitle: Text(attendanceRecord.userUID),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.location_city),
                    title: Text('User City'),
                    subtitle: Text(attendanceRecord.userCity),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('User Location Latitude'),
                    subtitle:
                        Text(attendanceRecord.userLocationLatitude.toString()),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.location_on),
                    title: Text('User Location Longitude'),
                    subtitle:
                        Text(attendanceRecord.userLocationLongitude.toString()),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text('User Attendance Date'),
                    subtitle: Text(attendanceRecord.dateTime.toString()),
                  ),
                  SizedBox(height: 10),
                  ListTile(
                    leading: Icon(Icons.location_city),
                    title: Text('User City'),
                    subtitle: Text(attendanceRecord.userCity),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.center,
                    child: ElevatedButton.icon(
                      onPressed: () => MapsLauncher.launchCoordinates(
                          attendanceRecord.userLocationLatitude,
                          attendanceRecord.userLocationLongitude),
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
