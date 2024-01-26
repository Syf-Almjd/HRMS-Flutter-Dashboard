import 'package:admin/presentation/Modules/SideBarTabs/ManageStaff/all_staff_info_dispaly.dart';
import 'package:admin/presentation/Shared/Components.dart';
import 'package:flutter/material.dart';

import '../Components/Header/header.dart';

class ManageStaffPage extends StatelessWidget {
  const ManageStaffPage();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(30),
      children: [
        Header(),
        getCube(5, context),
        AllStaffInfoDisplay(),
      ],
    );
  }
}
