part of 'tabs_cubit.dart';

enum Tabs {
  DashboardTab,
  StaffAttendanceTab,
  StaffEleaveTab,
  AnnouncementTab,
  EventsTab,
  ManageStaffTab,
  logoutTab,
  ProfileTab
}

@immutable
class TabsState {
  final Tabs appTab = Tabs.DashboardTab;
}

class DashboardTab extends TabsState {
  Tabs get appTab => Tabs.DashboardTab;
}

class StaffAttendanceTab extends TabsState {
  Tabs get appTab => Tabs.StaffAttendanceTab;
}

class StaffEleaveTab extends TabsState {
  Tabs get appTab => Tabs.StaffEleaveTab;
}

class AnnouncementTab extends TabsState {
  Tabs get appTab => Tabs.AnnouncementTab;
}

class EventsTab extends TabsState {
  Tabs get appTab => Tabs.EventsTab;
}

class ManageStaffTab extends TabsState {
  Tabs get appTab => Tabs.ManageStaffTab;
}

class LogoutTab extends TabsState {
  Tabs get appTab => Tabs.logoutTab;
}

class ProfileTab extends TabsState {
  Tabs get appTab => Tabs.ProfileTab;
}
