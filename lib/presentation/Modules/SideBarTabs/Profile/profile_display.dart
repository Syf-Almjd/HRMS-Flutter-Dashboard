import 'package:admin/config/utils/styles/app_colors.dart';
import 'package:admin/data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import 'package:admin/presentation/Cubits/navigation_cubit/navi_cubit.dart';
import 'package:admin/presentation/Shared/Components.dart';
import 'package:admin/presentation/Shared/WidgetBuilders.dart';
import 'package:flutter/material.dart';

import '../../../../domain/Models/UserModel.dart';
import '../../../Cubits/Tabs_cubit/tabs_cubit.dart';
import 'Screens/modify_admin_screen.dart';

class ProfileDisplay extends StatefulWidget {
  const ProfileDisplay();

  @override
  State<ProfileDisplay> createState() => _ProfileDisplayState();
}

class _ProfileDisplayState extends State<ProfileDisplay> {
  UserModel userModel = UserModel.loadingUser();

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    userModel = await RemoteDataCubit.get(context).getAdminData(context);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: getWidth(30, context),
                height: getHeight(40, context),
                child: previewImage(
                  photoRadius: 100,
                  onTap: () {
                    NaviCubit.get(context).navigate(
                        context,
                        ModifyAdminScreen(
                          userModel: userModel,
                        ));
                  },
                  fileUser: userModel.photoID,
                  context: context,
                ),
              ),

              Text(
                'Options',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              getCube(5, context),
              Wrap(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        NaviCubit.get(context).navigate(
                            context,
                            ModifyAdminScreen(
                              userModel: userModel,
                            ));
                      },
                      child: Text("Update Profile")),
                  getCube(5, context),
                  ElevatedButton(
                      onPressed: () {
                        showToast("Contact via: +601154225092",
                            AppColors.primaryColor, context);
                      },
                      child: Text("Contact Developer")),
                ],
              ),
              getCube(5, context),
              ElevatedButton(
                  onPressed: () {
                    showChoiceDialog(
                        context: context,
                        title: "Delete System Logs",
                        onNo: () {
                          TabsCubit.get(context)
                              .setTabScreen(Tabs.DashboardTab);
                        },
                        onYes: () {
                          TabsCubit.get(context)
                              .setTabScreen(Tabs.DashboardTab);
                          NaviCubit.get(context)
                              .navigateToSliderLogout(context);
                        });
                  },
                  child: Text("Delete System Logs")),

              // getCube(5, context),
              // Wrap(
              //   children: [
              //     FilledButton(
              //         onPressed: () {
              //           showToast("You are not allowed! Contact SuperAdmin: +601154225092", AppColors.primaryColor, context);
              //         },
              //         child: Text("Reset Password")),
              //     getCube(5, context),
              //     FilledButton(
              //         onPressed: () {
              //           showToast("You are not allowed! Contact SuperAdmin: +601154225092", AppColors.primaryColor, context);
              //         },
              //         child: Text("Add New Admin")),
              //   ],
              // ),
            ],
          ),
          Container(
            width: getWidth(35, context),
            child: ListView(
              children: [
                SizedBox(height: 20),
                Text(
                  'Profile Information',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                _buildProfileItem('UserID', userModel.userID),
                _buildProfileItem(
                  'Name',
                  userModel.name,
                ),
                _buildProfileItem(
                  'Email',
                  userModel.email,
                ),
                _buildProfileItem(
                  'Phone Number',
                  userModel.phoneNumber,
                ),
                _buildProfileItem(
                  'Address',
                  userModel.address,
                ),
                _buildProfileItem('Last Login', userModel.lastLogin),
                _buildProfileItem('Last Attend', userModel.lastAttend),
                _buildProfileItem('Last E-Leave', userModel.lastEleave),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProfileItem(
    String label,
    String value,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(width: 20),
          Flexible(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
