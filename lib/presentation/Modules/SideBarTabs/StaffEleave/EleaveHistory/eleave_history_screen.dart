import 'package:admin/domain/Models/eLeaveModel.dart';
import 'package:admin/presentation/Modules/SideBarTabs/StaffEleave/EleaveHistory/Builders/eleave_history_card.dart';
import 'package:flutter/material.dart';

import '../../../../../data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import '../../../../Shared/Components.dart';

class EleaveHistoryScreen extends StatefulWidget {
  final String userUID;
  const EleaveHistoryScreen({required this.userUID});

  @override
  State<EleaveHistoryScreen> createState() => _EleaveHistoryScreenState();
}

class _EleaveHistoryScreenState extends State<EleaveHistoryScreen> {
  List<EleaveModel> eleaveList = [];
  bool _isloaded = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  Future<void> getData() async {
    try {
      List<EleaveModel> data = await RemoteDataCubit.get(context)
          .getUserEleaveHistory(widget.userUID);

      if (mounted) {
        setState(() {
          eleaveList = data;
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
        child: eleaveList.isEmpty
            ? const Center(child: Text("There are no records yet. All Set!"))
            : ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: List.generate(eleaveList.length, (index) {
                  return EleaveHistoryCard(eleaveModel: eleaveList[index]);
                }),
              ),
      ),
    );
  }
}
