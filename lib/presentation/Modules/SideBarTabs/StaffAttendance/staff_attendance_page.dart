import 'package:admin/presentation/Modules/SideBarTabs/Components/AllStaff/all_staff_display.dart';
import 'package:admin/presentation/Shared/Components.dart';
import 'package:flutter/material.dart';

import '../Components/Header/header.dart';

class StaffAttendancePage extends StatelessWidget {
  const StaffAttendancePage();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(30),
      children: [
        Header(tabName: "Attendance"),
        getCube(5, context),
        AllStaffDisplay(),
      ],
    );
  }
}
