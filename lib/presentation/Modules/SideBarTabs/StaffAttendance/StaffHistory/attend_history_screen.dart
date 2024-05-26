import 'dart:html' as html;

import 'package:admin/presentation/Cubits/navigation_cubit/navi_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import '../../../../../domain/Models/UserModel.dart';
import '../../../../../domain/Models/attendanceModel.dart';
import '../../../../Shared/Components.dart';
import '../StaffReport/staff_report_generation.dart';
import 'Builders/attend_history_card.dart';

class AttendanceHistoryScreen extends StatefulWidget {
  final UserModel staffModel;
  const AttendanceHistoryScreen({required this.staffModel});

  @override
  State<AttendanceHistoryScreen> createState() =>
      _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState extends State<AttendanceHistoryScreen> {
  List<AttendanceModel> attendanceList = [];
  //
  // @override
  // void initState() {
  //   super.initState();
  //   getData();
  // }
  //
  // @override
  // void deactivate() {
  //   super.deactivate();
  // }
  //
  // Future<void> getData() async {
  //   try {
  //     List<AttendanceModel> data = await ;
  //
  //     if (mounted) {
  //       setState(() {
  //         attendanceList = data;
  //         _isloaded = true;
  //       });
  //     }
  //   } catch (error) {
  //     debugPrint(error.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
            child: IconButton(
              icon: const Icon(CupertinoIcons.printer),
              tooltip: 'Screenshot it',
              onPressed: () {
                html.window.print();
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
            child: IconButton(
              icon: const Icon(CupertinoIcons.cloud_download),
              tooltip: 'Download current month!',
              onPressed: () {
                NaviCubit.get(context).navigate(
                    context, StaffReportGenerator(widget.staffModel, false));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 12),
            child: IconButton(
              icon: const Icon(CupertinoIcons.download_circle),
              tooltip: 'Download All Data',
              onPressed: () {
                NaviCubit.get(context).navigate(
                    context, StaffReportGenerator(widget.staffModel, true));
              },
            ),
          ),
        ],
      ),
      body: StreamBuilder(
          stream: RemoteDataCubit.get(context)
              .getUserAttendanceHistory(widget.staffModel.userID, context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return loadingAnimation();
            }
            if (snapshot.hasError) {
              return Center(child: Text("Please try another time!"));
            }
            if (!snapshot.hasData) {
              return Center(child: Text("There are no records yet. All Set!"));
            }
            attendanceList.add(snapshot.data as AttendanceModel);
            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: attendanceList.length,
              itemBuilder: (context, index) {
                return AttendanceHistoryCard(
                  attendanceRecord: attendanceList[index],
                );
              },
            );
          }),
    );
  }
}
