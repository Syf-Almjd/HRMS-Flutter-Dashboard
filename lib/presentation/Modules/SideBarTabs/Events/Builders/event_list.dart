import 'package:admin/domain/Models/eventModel.dart';
import 'package:flutter/material.dart';

import '../../../../../config/utils/styles/app_colors.dart';
import '../../../../Shared/Components.dart';
import '../../../../Shared/WidgetBuilders.dart';

class EventList extends StatefulWidget {
  final EventModel eventModel;

  const EventList({Key? key, required this.eventModel}) : super(key: key);

  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
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
                  fileUser: widget.eventModel.image),
              ListTile(
                leading: Icon(Icons.title),
                title: Text('Event Title'),
                subtitle: Text(widget.eventModel.title),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.location_city),
                title: Text('Event Description'),
                subtitle: Text(widget.eventModel.description),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.date_range_rounded),
                title: Text('Event Date'),
                subtitle: Text(widget.eventModel.date),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.location_on),
                title: Text('Event Location'),
                subtitle: Text(widget.eventModel.location),
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
