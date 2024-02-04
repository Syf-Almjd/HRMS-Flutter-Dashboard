import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

import '../../../../config/utils/managers/app_enums.dart';
import '../../../../data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import '../../../../domain/Models/announcementModel.dart';
import '../../../Shared/WidgetBuilders.dart';
import 'Builders/announcement_list.dart';

class AnnouncementDisplay extends StatefulWidget {
  const AnnouncementDisplay({Key? key}) : super(key: key);

  @override
  State<AnnouncementDisplay> createState() => _AnnouncementDisplayState();
}

class _AnnouncementDisplayState extends State<AnnouncementDisplay> {
  List<AnnouncementModel> announcementList = [];
  bool loaded = false;

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
      List<AnnouncementModel> data = await RemoteDataCubit.get(context)
          .getAnnouncementPostsData()
          .then((value) => value.cast<AnnouncementModel>().toList());

      if (mounted) {
        setState(() {
          announcementList = data;
          loaded = true;
        });
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
      delay: Duration(milliseconds: 300),
      child: loaded
          ? Column(
              children: List.generate(
                  announcementList.length,
                  (index) => AnnouncementList(
                      announcementModel: announcementList[index])),
            )
          : getSkeletonLoading(type: PostsType.announcements),
    );
  }
}
