import 'package:admin/domain/Models/eventModel.dart';
import 'package:admin/presentation/Modules/SideBarTabs/Events/Screens/delete_event_screen.dart';
import 'package:admin/presentation/Modules/SideBarTabs/Events/Screens/modify_event_screen.dart';
import 'package:flutter/material.dart';

import '../../../../../config/utils/styles/app_colors.dart';
import '../../../../Cubits/navigation_cubit/navi_cubit.dart';
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
          borderRadius: BorderRadius.circular(15),
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
                subtitle: Text(widget.eventModel.locationName),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.location_history),
                title: Text('Location Latitude'),
                subtitle: Text(widget.eventModel.locationLatitude),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.location_searching_sharp),
                title: Text('Location Longitude'),
                subtitle: Text(widget.eventModel.locationLongitude),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      NaviCubit.get(context).navigate(
                          context,
                          ModifyEventScreen(
                            eventModel: widget.eventModel,
                          ));
                    },
                    icon: Icon(Icons.edit),
                    label: Text('Modify'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      NaviCubit.get(context).navigate(
                          context, DeleteEventScreen(widget.eventModel));
                    },
                    icon: Icon(Icons.delete),
                    label: Text('delete'),
                  ),
                  SizedBox(height: 10),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
