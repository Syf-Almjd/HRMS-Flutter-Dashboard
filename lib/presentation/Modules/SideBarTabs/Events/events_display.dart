import 'package:admin/domain/Models/eventModel.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

import '../../../../config/utils/managers/app_enums.dart';
import '../../../../data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import '../../../Shared/WidgetBuilders.dart';
import 'Builders/event_list.dart';

class EventsDisplay extends StatefulWidget {
  const EventsDisplay({Key? key}) : super(key: key);

  @override
  State<EventsDisplay> createState() => _EventsDisplayState();
}

class _EventsDisplayState extends State<EventsDisplay> {
  List<EventModel> eventModels = [];
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
      List<EventModel> data = await RemoteDataCubit.get(context)
          .getEventPostsData()
          .then((value) => value.cast<EventModel>().toList());
      if (mounted) {
        setState(() {
          eventModels = data;
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
                  eventModels.length,
                  (index) => EventList(
                        eventModel: eventModels[index],
                      )),
            )
          : getSkeletonLoading(type: PostsType.announcements),
    );
  }
}
