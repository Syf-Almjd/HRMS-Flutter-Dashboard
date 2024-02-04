import 'package:admin/domain/Models/announcementModel.dart';
import 'package:admin/domain/Models/eventModel.dart';
import 'package:admin/presentation/Shared/Components.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

import '../../../../../config/utils/managers/app_values.dart';
import '../../../../../config/utils/styles/app_colors.dart';
import '../../../../../data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import '../../../../Cubits/Tabs_cubit/tabs_cubit.dart';
import 'Builders/posts_info_card.dart';
import 'chart.dart';

class PostsDetails extends StatefulWidget {
  const PostsDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<PostsDetails> createState() => _PostsDetailsState();
}

List<AnnouncementModel> announcementPosts = [];
List<EventModel> eventsPosts = [];

class _PostsDetailsState extends State<PostsDetails> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    try {
      announcementPosts = await RemoteDataCubit.get(context)
          .getAnnouncementPostsData()
          .then((value) => value.cast<AnnouncementModel>().toList());
      eventsPosts = await RemoteDataCubit.get(context)
          .getEventPostsData()
          .then((value) => value.cast<EventModel>().toList());
      if (mounted) {
        setState(() {});
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(AppPadding.p16),
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: (eventsPosts.isNotEmpty && announcementPosts.isNotEmpty)
            ? DelayedDisplay(
                slidingCurve: Curves.fastOutSlowIn,
                delay: Duration(milliseconds: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Posts Statistics",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: AppPadding.p16),
                    Chart(),
                    PostsInfoCard(
                        svgSrc: "assets/icons/sound_file.svg",
                        title: "Latest Announcements",
                        numberOfPosts: getTodayPosts(announcementPosts),
                        date:
                            "Updated ${getDateTimeToDay(announcementPosts.last.date)}",
                        onTap: () {
                          TabsCubit.get(context)
                              .setTabScreen(Tabs.AnnouncementTab);
                        }),
                    PostsInfoCard(
                        svgSrc: "assets/icons/one_drive.svg",
                        title: "Latest Events",
                        numberOfPosts: getTodayPosts(eventsPosts),
                        date:
                            "Updated ${getDateTimeToDay(eventsPosts.last.date)}",
                        onTap: () {
                          TabsCubit.get(context).setTabScreen(Tabs.EventsTab);
                        }),
                    PostsInfoCard(
                        svgSrc: "assets/icons/doc_file.svg",
                        title: "Total Announcements",
                        numberOfPosts: announcementPosts.length.toString(),
                        date:
                            "Last updated: ${getDateTimeToDay(announcementPosts.last.date)}",
                        onTap: () {
                          TabsCubit.get(context)
                              .setTabScreen(Tabs.AnnouncementTab);
                        }),
                    PostsInfoCard(
                        svgSrc: "assets/icons/media_file.svg",
                        title: "Total Events",
                        numberOfPosts: eventsPosts.length.toString(),
                        date:
                            "Last updated: ${getDateTimeToDay(eventsPosts.last.date)}",
                        onTap: () {
                          TabsCubit.get(context).setTabScreen(Tabs.EventsTab);
                        }),
                  ],
                ),
              )
            : loadingAnimation());
  }

  getTodayPosts(model) {
    int total = 0;
    for (var element in model) {
      if (DateTime.now().day == DateTime.parse(element.date).day) {
        total = total + 1;
      }
    }
    return total.toString();
  }
}
