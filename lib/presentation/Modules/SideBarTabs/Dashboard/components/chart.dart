import 'package:admin/config/utils/managers/app_values.dart';
import 'package:admin/data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../../config/utils/styles/app_colors.dart';

class Chart extends StatefulWidget {
  const Chart({
    Key? key,
  }) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

int announcementPosts = 1;
int eventsPosts = 1;

class _ChartState extends State<Chart> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    announcementPosts = await RemoteDataCubit.get(context)
        .getAnnouncementPostsData()
        .then((value) => value.length);
    eventsPosts = await RemoteDataCubit.get(context)
        .getEventPostsData()
        .then((value) => value.length);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: [
                PieChartSectionData(
                  color: AppColors.lowPriority,
                  value: getValue(announcementPosts),
                  showTitle: true,
                  titleStyle: TextStyle(fontSize: 10),
                  title: "Announcements",
                  radius: 25,
                ),
                PieChartSectionData(
                  color: AppColors.primaryColor,
                  title: "Events",
                  showTitle: true,
                  titleStyle: TextStyle(fontSize: 10),
                  value: getValue(eventsPosts),
                  radius: 22,
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: AppPadding.p16),
                Text(
                  "${announcementPosts + eventsPosts}",
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        height: 1,
                      ),
                ),
                Text("Total Posts")
              ],
            ),
          ),
        ],
      ),
    );
  }

  getValue(int value) {
    if (value == announcementPosts)
      return (announcementPosts / ((announcementPosts + eventsPosts) / 100));
    else
      return (eventsPosts / ((announcementPosts + eventsPosts) / 100));
  }
}
