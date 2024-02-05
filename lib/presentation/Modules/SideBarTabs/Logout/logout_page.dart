import 'package:admin/presentation/Cubits/Tabs_cubit/tabs_cubit.dart';
import 'package:admin/presentation/Cubits/navigation_cubit/navi_cubit.dart';
import 'package:admin/presentation/Shared/Components.dart';
import 'package:flutter/material.dart';

class LogOutPage extends StatelessWidget {
  const LogOutPage();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 200)).then((_) => showChoiceDialog(
        context: context,
        title: "Logout Admin User",
        onNo: () {
          TabsCubit.get(context).setTabScreen(Tabs.DashboardTab);
        },
        onYes: () {
          TabsCubit.get(context).setTabScreen(Tabs.DashboardTab);
          NaviCubit.get(context).navigateToSliderLogout(context);
        }));
    return Container();
  }
}
