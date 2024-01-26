import 'package:flutter/material.dart';

import '../../../../../config/utils/styles/app_colors.dart';
import '../../../../../domain/Models/announcementModel.dart';
import '../../../../Shared/Components.dart';
import '../../../../Shared/WidgetBuilders.dart';

class AnnouncementList extends StatefulWidget {
  final AnnouncementModel announcementModel;

  const AnnouncementList({Key? key, required this.announcementModel})
      : super(key: key);

  @override
  _AnnouncementListState createState() => _AnnouncementListState();
}

class _AnnouncementListState extends State<AnnouncementList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: getWidth(35, context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.primaryColor),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              previewImage(
                  editable: false,
                  context: context,
                  fileUser: widget.announcementModel.image),
              ListTile(
                leading: Icon(Icons.title),
                title: Text('Title'),
                subtitle: Text(widget.announcementModel.title),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.mode_standby),
                title: Text('Description'),
                subtitle: Text(widget.announcementModel.description),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.date_range_outlined),
                title: Text('Date'),
                subtitle: Text(widget.announcementModel.date),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // _launchInMaps(
                      //   attendanceRecord.userLocationLatitude,
                      //   attendanceRecord.userLocationLongitude);
                    },
                    icon: Icon(Icons.edit),
                    label: Text('Modify'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      // _launchInMaps(
                      //   attendanceRecord.userLocationLatitude,
                      //   attendanceRecord.userLocationLongitude);
                    },
                    icon: Icon(Icons.delete),
                    label: Text('delete'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
