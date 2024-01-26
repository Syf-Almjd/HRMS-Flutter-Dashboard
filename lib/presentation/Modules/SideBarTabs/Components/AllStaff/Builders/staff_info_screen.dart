import 'package:admin/domain/Models/attendanceModel.dart';
import 'package:admin/presentation/Shared/Components.dart';
import 'package:admin/presentation/Shared/WidgetBuilders.dart';
import 'package:flutter/material.dart';

class StaffInfoScreen extends StatelessWidget {
  final AttendanceModel userModel;

  const StaffInfoScreen(this.userModel);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.all(50),
        children: [
          previewImage(fileUser: userModel.userPhoto, context: context),
          getCube(5, context),
          Text("dateTime: ${userModel.dateTime}"),
          getCube(5, context),
          Text("userCity: ${userModel.userCity}"),
          getCube(5, context),
          Text("userLocationLongitude: ${userModel.userLocationLongitude}"),
          getCube(5, context),
          Text("userLocationLatitude: ${userModel.userLocationLatitude}"),
          getCube(5, context),
          Text("userUID: ${userModel.userUID}"),
        ],
      ),
    );
  }
}
