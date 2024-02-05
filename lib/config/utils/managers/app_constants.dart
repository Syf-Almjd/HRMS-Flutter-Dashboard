import 'package:flutter/material.dart';

abstract class AppConstants {
  static const String appTitle = "TASKFORCE HR";
  static List<String> homeTabs = [
    "Attendance",
    "E-Leave",
    "Announcement",
    "Events",
    "Profile"
  ];

  static const String savedUser = "currentuser";

  static String inTapCalenderTitle = "Calender:";
  static const String appFontFamily = "poppins";
  static const String savedAppLanguage = "savedAppLanguage";

  ///Local Attendance Record
  static String userLocalAttendance = "userAttendance";

  ///Firebase Data
  static String usersCollection = "Users";
  static String allStaffCollection = "Users/PPKstaff/members";
  static String adminsData = "Admins";
  static String adminEmail = "admin@ppk.com";
  static String ppkAdminData = "PPKAdmin";
  static String PPKstaff = "PPKstaff";
  static String staffKey = "staffKey";

  static String lastAttend = "lastAttend";
  static String lastLogin = "lastLogin";

  ///Attendance
  static String attendanceRecordCollection = "attendanceRecord";
  static String attendanceStaffCollection = "/Tabs/attendance/PPKstaff";

  ///Eleave
  static String eLeaveRecordCollection = "eleaveRecord";
  static String eLeaveStaffCollection = "/Tabs/eleave/PPKstaff/";

  ///Other
  static String announcementCollection = "/Tabs/announcement/PPKstaff";
  static String eventsCollection = "/Tabs/events/PPKstaff";
  static String noPhotoUser = "NOPHOTO";

  static List<String> profileCardsName = [
    "Modify Account",
    "Notifications",
    "Report a problem",
    "Share",
    "Logout"
  ];
  static List<IconData> profileCardsIcons = [
    Icons.edit_attributes_outlined,
    Icons.notifications_active_outlined,
    Icons.report_problem_outlined,
    Icons.offline_share,
    Icons.door_back_door_outlined,
  ];
}
