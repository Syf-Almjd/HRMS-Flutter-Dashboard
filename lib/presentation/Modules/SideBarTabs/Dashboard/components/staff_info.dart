import 'package:admin/config/utils/styles/app_colors.dart';
import 'package:admin/data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import 'package:admin/presentation/Shared/Components.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';

import '../../../../../config/utils/demoModels/StaffStroageModel.dart';
import '../../../../../config/utils/managers/app_values.dart';
import 'Builders/staff_info_card.dart';

class StaffStatistics extends StatefulWidget {
  const StaffStatistics({
    Key? key,
  }) : super(key: key);

  @override
  State<StaffStatistics> createState() => _StaffStatisticsState();
}

List staffStorageCards = [];

class _StaffStatisticsState extends State<StaffStatistics> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    int staffAttend = 0;
    int staffAbsent = 0;
    var data =
        await RemoteDataCubit.get(context).getLatestStaffAttendance(context);
    for (var element in data) {
      if (DateTime.parse(element).day == DateTime.now().day) {
        staffAttend++;
      }
    }
    staffAbsent = data.length - staffAttend;
    staffStorageCards = [
      StaffStorageInfo(
        title: "Staff Attendance",
        numOfFiles: staffAttend.toString(),
        svgSrc: "assets/icons/Documents.svg",
        totalStorage: data.length.toString(),
        color: AppColors.primaryColor,
        percentage: getTotalPercent(staffAttend, data.length),
      ),
      StaffStorageInfo(
        title: "Staff Absence",
        numOfFiles: staffAbsent.toString(),
        svgSrc: "assets/icons/google_drive.svg",
        totalStorage: data.length.toString(),
        color: Color(0xFFFFA113),
        percentage: getTotalPercent(staffAbsent, data.length),
      ),
    ];
    if (mounted) {
      setState(() {
        staffStorageCards = staffStorageCards;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Staff Statistics",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: AppPadding.p16 * 1.5,
                  vertical:
                      AppPadding.p16 / (Responsive.isMobile(context) ? 2 : 1),
                ),
              ),
              onPressed: () {
                showToast("user register", AppColors.primaryColor, context);
              },
              icon: Icon(Icons.add),
              label: Text("Add New staff"),
            ),
          ],
        ),
        SizedBox(height: AppPadding.p16),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }

  getTotalPercent(int value, int total) {
    return ((value ~/ (total / 100)));
  }
}

class FileInfoCardGridView extends StatefulWidget {
  FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  State<FileInfoCardGridView> createState() => _FileInfoCardGridViewState();
}

class _FileInfoCardGridViewState extends State<FileInfoCardGridView> {
  @override
  Widget build(BuildContext context) {
    return staffStorageCards.isNotEmpty
        ? GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: staffStorageCards.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.crossAxisCount,
              crossAxisSpacing: AppPadding.p16,
              mainAxisSpacing: AppPadding.p16,
              childAspectRatio: widget.childAspectRatio,
            ),
            itemBuilder: (context, index) => StaffInfoCard(
              info: staffStorageCards[index],
              onTap: () {},
            ),
          )
        : loadingAnimation();
  }
}
