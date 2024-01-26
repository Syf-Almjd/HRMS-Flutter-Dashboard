import 'package:admin/data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import 'package:admin/domain/Models/UserModel.dart';
import 'package:admin/presentation/Shared/Components.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

import '../../../../../config/utils/managers/app_values.dart';
import '../../../../../config/utils/styles/app_colors.dart';
import '../../../../Cubits/navigation_cubit/navi_cubit.dart';
import '../../StaffAttendance/StaffHistory/attend_history_screen.dart';

class AllStaffDisplay extends StatefulWidget {
  const AllStaffDisplay({
    Key? key,
  }) : super(key: key);

  @override
  State<AllStaffDisplay> createState() => _AllStaffDisplayState();
}

List<UserModel> staffMembers = [];

class _AllStaffDisplayState extends State<AllStaffDisplay> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    staffMembers = await RemoteDataCubit.get(context).getAllStaff(context);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppPadding.p16),
      decoration: BoxDecoration(
        color: AppColors.secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "All Staff Members",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          staffMembers.isNotEmpty
              ? DelayedDisplay(
                  delay: Duration(milliseconds: 500),
                  child: SizedBox(
                    width: double.infinity,
                    child: DataTable(
                      columnSpacing: AppPadding.p16,
                      // minWidth: 600,
                      columns: [
                        DataColumn(
                          label: Text("Name"),
                        ),
                        DataColumn(
                          label: Text("Last Active"),
                        ),
                        DataColumn(
                          label: Text("Other"),
                        ),
                      ],
                      rows: List.generate(
                        staffMembers.length,
                        (index) =>
                            staffInfoDataRow(staffMembers[index], context),
                      ),
                    ),
                  ),
                )
              : loadingAnimation()
        ],
      ),
    );
  }
}

DataRow staffInfoDataRow(UserModel userModel, context) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
              child: Text(userModel.name),
            ),
          ],
        ),
      ),
      DataCell(Text(getDateTimeToDay(userModel.lastLogin))),
      DataCell(InkWell(
        hoverColor: Colors.transparent,
        onTap: () async {
          // var model = await RemoteDataCubit.get(context)
          //     .getUserAttendanceHistory(userModel.userID, context);
          NaviCubit.get(context).navigate(
              context, AttendanceHistoryScreen(userUID: userModel.userID));
          // NaviCubit.get(context).navigate(context, StaffInfoScreen(model.last));
        },
        child: Text(
          "More...",
          style: TextStyle(color: AppColors.primaryColor),
        ),
      ))
    ],
  );
}
