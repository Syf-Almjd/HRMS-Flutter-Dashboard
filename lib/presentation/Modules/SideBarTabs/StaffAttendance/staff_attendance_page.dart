import 'package:admin/data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import 'package:admin/presentation/Modules/SideBarTabs/Components/AllStaff/all_staff.dart';
import 'package:admin/presentation/Shared/Components.dart';
import 'package:flutter/material.dart';

import '../Components/Header/header.dart';

class StaffAttendancePage extends StatefulWidget {
  const StaffAttendancePage();

  @override
  State<StaffAttendancePage> createState() => _StaffAttendancePageState();
}

class _StaffAttendancePageState extends State<StaffAttendancePage> {
  @override
  void initState() {
    getStaffData();
    super.initState();
  }

  getStaffData() {
    RemoteDataCubit.get(context).getLatestStaffAttendance(context);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(30),
      children: [
        Header(),
        getCube(5, context),
        AllStaffDisplay(),
      ],
    );
  }
}
