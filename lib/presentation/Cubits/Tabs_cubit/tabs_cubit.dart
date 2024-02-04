import 'package:admin/presentation/Modules/SideBarTabs/Announcement/announcement_page.dart';
import 'package:admin/presentation/Modules/SideBarTabs/StaffAttendance/staff_attendance_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Modules/SideBarTabs/Dashboard/dashboard_screen.dart';
import '../../Modules/SideBarTabs/Events/event_page.dart';
import '../../Modules/SideBarTabs/Logout/logout_page.dart';
import '../../Modules/SideBarTabs/ManageStaff/staff_attendance_page.dart';
import '../../Modules/SideBarTabs/StaffEleave/staff_eleave_page.dart';

part 'tabs_state.dart';

class TabsCubit extends Cubit<TabsState> {
  TabsCubit() : super(TabsState());

  static TabsCubit get(context) => BlocProvider.of(context);

  setTabScreen(Tabs newTab) {
    switch (newTab) {
      case Tabs.DashboardTab:
        emit(DashboardTab());
        break;
      case Tabs.StaffAttendanceTab:
        emit(StaffAttendanceTab());
        break;
      case Tabs.StaffEleaveTab:
        emit(StaffEleaveTab());
        break;
      case Tabs.AnnouncementTab:
        emit(AnnouncementTab());
        break;
      case Tabs.EventsTab:
        emit(EventsTab());
        break;
      case Tabs.ManageStaffTab:
        emit(ManageStaffTab());
        break;
      case Tabs.logoutTab:
        emit(LogoutTab());
        break;
      case Tabs.ProfileTab:
        emit(ProfileTab());
        break;
      default:
        emit(DashboardTab());
        break;
    }
  }

  Widget getTabScreen() {
    switch (state.appTab) {
      case Tabs.DashboardTab:
        return DashboardScreen();
      case Tabs.StaffAttendanceTab:
        return StaffAttendancePage();
      case Tabs.StaffEleaveTab:
        return StaffEleavePage(); //TODO change later and down also>>
      case Tabs.AnnouncementTab:
        return AnnouncementPage();
      case Tabs.EventsTab:
        return EventsPage();
      case Tabs.ManageStaffTab:
        return ManageStaffPage();
      case Tabs.logoutTab:
        return LogOutPage();
      case Tabs.ProfileTab:
        return DashboardScreen();
      default:
        return DashboardScreen();
    }
  }
}
