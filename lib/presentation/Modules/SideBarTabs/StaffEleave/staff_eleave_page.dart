import 'package:admin/presentation/Modules/SideBarTabs/StaffEleave/eleave_staff_display.dart';
import 'package:admin/presentation/Shared/Components.dart';
import 'package:flutter/material.dart';

import '../Components/Header/header.dart';

class StaffEleavePage extends StatelessWidget {
  const StaffEleavePage();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(30),
      children: [
        Header(),
        getCube(5, context),
        EleaveStaffDisplay(),
      ],
    );
  }
}
