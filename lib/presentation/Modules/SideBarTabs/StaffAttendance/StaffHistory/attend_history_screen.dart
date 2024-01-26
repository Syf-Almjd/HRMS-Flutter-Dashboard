import 'package:flutter/material.dart';

import '../../../../../data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import '../../../../../domain/Models/attendanceModel.dart';
import '../../../../Shared/Components.dart';
import 'Builders/attend_history_card.dart';

class AttendanceHistoryScreen extends StatefulWidget {
  final String userUID;
  const AttendanceHistoryScreen({required this.userUID});

  @override
  State<AttendanceHistoryScreen> createState() =>
      _AttendanceHistoryScreenState();
}

class _AttendanceHistoryScreenState extends State<AttendanceHistoryScreen> {
  List<AttendanceModel> attendanceList = [];
  bool _isloaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  Future<void> getData() async {
    try {
      List<AttendanceModel> data = await RemoteDataCubit.get(context)
          .getUserAttendanceHistory(widget.userUID, context);

      if (mounted) {
        setState(() {
          attendanceList = data;
          _isloaded = true;
        });
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Visibility(
        visible: _isloaded,
        replacement: loadingAnimation(),
        child: attendanceList.isEmpty
            ? const Center(child: Text("There are no records yet. All Set!"))
            : ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: List.generate(attendanceList.length, (index) {
                  return AttendanceHistoryCard(
                      attendanceRecord: attendanceList[index]);
                }),
              ),
      ),
    );
  }
}
