import 'package:admin/config/utils/managers/app_values.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';

import '../Components/AllStaff/all_staff_display.dart';
import '../Components/Header/header.dart';
import 'components/posts_details.dart';
import 'components/staff_info.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: EdgeInsets.all(AppPadding.p14),
        child: Column(
          children: [
            Header(),
            SizedBox(height: AppPadding.p16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      StaffStatistics(),
                      SizedBox(height: AppPadding.p16),
                      AllStaffDisplay(),
                      if (Responsive.isMobile(context))
                        SizedBox(height: AppPadding.p16),
                      if (Responsive.isMobile(context)) PostsDetails(),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: AppPadding.p16),
                // On Mobile means if the screen is less than 850 we don't want to show it
                if (!Responsive.isMobile(context))
                  Expanded(
                    flex: 2,
                    child: PostsDetails(),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
