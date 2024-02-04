import 'package:admin/data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import 'package:admin/domain/Models/announcementModel.dart';
import 'package:admin/presentation/Cubits/navigation_cubit/navi_cubit.dart';
import 'package:admin/presentation/Shared/Components.dart';
import 'package:flutter/material.dart';

class DeleteAnnouncementScreen extends StatelessWidget {
  final AnnouncementModel announcementModel;

  const DeleteAnnouncementScreen(this.announcementModel);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 200))
        .then((value) => showChoiceDialog(
            context: context,
            title: "Delete Announcement",
            onNo: () {
              NaviCubit.get(context).pop(context);
            },
            onYes: () {
              RemoteDataCubit.get(context)
                  .deleteAnnouncementPostsData(announcementModel)
                  .then((value) => NaviCubit.get(context).pop(context));
            }));
    return Container(
      color: Colors.white,
    );
  }
}
