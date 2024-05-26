import 'dart:convert';
import 'dart:html' as html;

import 'package:admin/data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import 'package:admin/domain/Models/UserModel.dart';
import 'package:admin/domain/Models/attendanceModel.dart';
import 'package:admin/presentation/Cubits/navigation_cubit/navi_cubit.dart';
import 'package:admin/presentation/Shared/Components.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class StaffReportGenerator extends StatefulWidget {
  final UserModel userModel;
  final bool isFullDownload;
  const StaffReportGenerator(this.userModel, this.isFullDownload);

  @override
  State<StaffReportGenerator> createState() => _StaffReportGeneratorState();
}

class _StaffReportGeneratorState extends State<StaffReportGenerator> {
  List<AttendanceModel> staffReportList = [];

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    if (widget.isFullDownload == false) {
      staffReportList = await RemoteDataCubit.get(context)
          .getUserReportAttendanceHistory(widget.userModel.userID, context, 30);
    } else {
      staffReportList = await RemoteDataCubit.get(context)
          .getUserReportAttendanceHistory(
              widget.userModel.userID, context, 1000);
    }
    await createExcel();
    NaviCubit.get(context).pop(context);
  }

  createExcel() {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel["Sheet1"];
    sheetObject.setDefaultRowHeight(200);
    sheetObject.setDefaultColumnWidth(35);
    sheetObject.appendRow([
      TextCellValue("Name: ${widget.userModel.name}"),
      TextCellValue("Phone Number: ${widget.userModel.phoneNumber}"),
      TextCellValue("USER ID: ${widget.userModel.userID}")
    ]);
    sheetObject.appendRow([
      TextCellValue(""),
    ]);
    sheetObject.appendRow([
      TextCellValue("Check In Date"),
      TextCellValue("Check Out Date"),
      TextCellValue("Attendance City"),
      TextCellValue("User Location Longitude"),
      TextCellValue("User Location Latitude"),
      TextCellValue("Link for Location"),
    ]);

    for (var staff in staffReportList) {
      sheetObject.appendRow([
        TextCellValue(staff.dateTime),
        TextCellValue(staff.checkOutTime),
        TextCellValue(staff.userCity),
        TextCellValue(staff.userLocationLongitude),
        TextCellValue(staff.userLocationLatitude),
        TextCellValue(
            "https://www.google.com/maps/place/${staff.userLocationLatitude},${staff.userLocationLongitude}"),
      ]);
    }

    // Encode the Excel file
    final encodedExcel = excel.encode();

    if (encodedExcel != null) {
      // Convert the encoded Excel file to base64
      final base64Data = base64Encode(encodedExcel);

      // Create a data URI for the Excel file
      final dataUri =
          'data:application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;base64,$base64Data';

      // Create an anchor element to trigger the download
      final anchor = html.AnchorElement(href: dataUri)
        ..setAttribute("download", "${widget.userModel.name}_report.xlsx")
        ..click();
    } else {
      // Handle encoding failure
      print("Error: Failed to encode Excel file.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loadingAnimation(
                loadingType: LoadingAnimationWidget.waveDots(
                    color: Colors.white, size: 50)),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                  "File is Processing, You will be forwarded automatically once finished!"),
            ),
          ],
        ),
      ),
    );
  }
}
