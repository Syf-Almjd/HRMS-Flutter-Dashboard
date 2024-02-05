import 'package:admin/presentation/Cubits/navigation_cubit/navi_cubit.dart';
import 'package:admin/presentation/Modules/SideBarTabs/ManageStaff/Screens/add_staff_screen.dart';
import 'package:admin/presentation/Modules/SideBarTabs/ManageStaff/Screens/delete_staff_screen.dart';
import 'package:admin/presentation/Shared/WidgetBuilders.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

import '../../../../config/utils/managers/app_values.dart';
import '../../../../config/utils/styles/app_colors.dart';
import '../../../../data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import '../../../../domain/Models/UserModel.dart';
import '../../../Shared/Components.dart';
import 'Screens/modify_staff_screen.dart';

class AllStaffInfoDisplay extends StatefulWidget {
  const AllStaffInfoDisplay();

  @override
  State<AllStaffInfoDisplay> createState() => _AllStaffInfoDisplayState();
}

List<UserModel> staffMembers = [];

class _AllStaffInfoDisplayState extends State<AllStaffInfoDisplay> {
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
            "Staff Registration Key",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          getCube(2, context),
          Text(
            "Manage Staff Members",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child:
                    Text("", style: TextStyle(fontSize: getHeight(3, context))),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextButton.icon(
                    onPressed: () {
                      NaviCubit.get(context)
                          .navigate(context, AddStaffScreen());
                    },
                    icon: Icon(Icons.add_circle_outline_rounded),
                    label: Text("Add New Staff")),
              ),
            ],
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
                          label: Text("Photo"),
                        ),
                        DataColumn(
                          label: Text("Name"),
                        ),
                        DataColumn(
                          label: Text("Email"),
                        ),
                        DataColumn(
                          label: Text("Phone Number"),
                        ),
                        DataColumn(
                          label: Text("Last Active"),
                        ),
                        DataColumn(
                          label: Text("User ID"),
                        ),
                        DataColumn(
                          label: Text("Address"),
                        ),
                        DataColumn(
                          label: Text(""),
                        ),
                        DataColumn(
                          label: Text(""),
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
      DataCell(Container(
        width: getWidth(5, context),
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: previewImage(fileUser: userModel.photoID, context: context),
      )),
      DataCell(Container(
        width: getWidth(5, context),
        child: Text(
          userModel.name,
          overflow: TextOverflow.ellipsis,
        ),
      )),
      DataCell(Container(
        width: getWidth(5, context),
        child: Text(
          userModel.email,
          overflow: TextOverflow.ellipsis,
        ),
      )),
      DataCell(Container(
        width: getWidth(5, context),
        child: Text(
          userModel.phoneNumber,
          overflow: TextOverflow.ellipsis,
        ),
      )),
      DataCell(Container(
        width: getWidth(5, context),
        child: Text(
          userModel.lastLogin,
          overflow: TextOverflow.ellipsis,
        ),
      )),
      DataCell(Container(
        width: getWidth(5, context),
        child: Text(
          userModel.userID,
          overflow: TextOverflow.ellipsis,
        ),
      )),
      DataCell(Container(
          width: getWidth(7, context),
          child: Text(
            userModel.address,
            overflow: TextOverflow.ellipsis,
          ))),
      DataCell(TextButton(
        onPressed: () {
          NaviCubit.get(context).navigate(
              context,
              ModifyStaffScreen(
                userModel: userModel,
              ));
        },
        child: Text(
          "Edit",
          style: TextStyle(color: AppColors.primaryColor),
        ),
      )),
      DataCell(TextButton(
        onPressed: () {
          NaviCubit.get(context)
              .navigate(context, DeleteStaffScreen(userModel));
        },
        child: Text(
          "Delete",
          style: TextStyle(color: AppColors.redColor),
        ),
      )),
    ],
  );
}
