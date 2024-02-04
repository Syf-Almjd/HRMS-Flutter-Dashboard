import 'package:admin/data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import 'package:admin/domain/Models/eLeaveModel.dart';
import 'package:admin/presentation/Shared/Components.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

import '../../../../config/utils/managers/app_values.dart';
import '../../../../config/utils/styles/app_colors.dart';
import '../../../Cubits/navigation_cubit/navi_cubit.dart';
import 'EleaveHistory/eleave_history_screen.dart';

class EleaveStaffDisplay extends StatefulWidget {
  const EleaveStaffDisplay({
    Key? key,
  }) : super(key: key);

  @override
  State<EleaveStaffDisplay> createState() => _EleaveStaffDisplayState();
}

List<EleaveModel> staffMembers = [];

class _EleaveStaffDisplayState extends State<EleaveStaffDisplay> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    staffMembers = await RemoteDataCubit.get(context).getEleaveStaff();
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
            "E-leave Staff Members",
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
                          label: Text("Time Applied"),
                        ),
                        DataColumn(
                          label: Text("Description"),
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
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text("There are no E-Leave Requests")),
                )
        ],
      ),
    );
  }
}

DataRow staffInfoDataRow(EleaveModel eleaveModel, context) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
              child: Text(eleaveModel.userName),
            ),
          ],
        ),
      ),
      DataCell(Text(getDateTimeToDay(eleaveModel.dateTime))),
      DataCell(Text(eleaveModel.requestInfo)),
      DataCell(InkWell(
        hoverColor: Colors.transparent,
        onTap: () async {
          NaviCubit.get(context).navigate(
              context, EleaveHistoryScreen(userUID: eleaveModel.userUID));
        },
        child: Text(
          "More...",
          style: TextStyle(color: AppColors.primaryColor),
        ),
      ))
    ],
  );
}
