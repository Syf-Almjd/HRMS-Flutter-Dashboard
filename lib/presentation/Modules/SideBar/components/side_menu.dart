import 'package:admin/presentation/Cubits/Tabs_cubit/tabs_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {
              TabsCubit.get(context).setTabScreen(Tabs.DashboardTab);
            },
          ),
          DrawerListTile(
            title: "Staff Attendance",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              TabsCubit.get(context).setTabScreen(Tabs.StaffAttendanceTab);
            },
          ),
          DrawerListTile(
            title: "Staff E-Leave",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              TabsCubit.get(context).setTabScreen(Tabs.StaffEleaveTab);
            },
          ),
          DrawerListTile(
            title: "Announcements",
            svgSrc: "assets/icons/menu_doc.svg",
            press: () {
              TabsCubit.get(context).setTabScreen(Tabs.AnnouncementTab);
            },
          ),
          DrawerListTile(
            title: "Events",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {
              TabsCubit.get(context).setTabScreen(Tabs.EventsTab);
            },
          ),
          DrawerListTile(
            title: "Manage Staff",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {
              TabsCubit.get(context).setTabScreen(Tabs.ManageStaffTab);
            },
          ),
          DrawerListTile(
            title: "Profile",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Log out",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {
              TabsCubit.get(context).setTabScreen(Tabs.logoutTab);
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 5.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
