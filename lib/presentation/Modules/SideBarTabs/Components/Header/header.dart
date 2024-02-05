import 'package:admin/domain/Models/UserModel.dart';
import 'package:admin/presentation/Cubits/Tabs_cubit/tabs_cubit.dart';
import 'package:admin/responsive.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../config/utils/managers/app_values.dart';
import '../../../../../config/utils/styles/app_colors.dart';
import '../../../../../domain/controllers/MenuAppController.dart';
import '../../../../Shared/ClockWidget.dart';
import '../../../../Shared/WidgetBuilders.dart';

class Header extends StatelessWidget {
  final String tabName;
  const Header({
    Key? key,
    required this.tabName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DelayedDisplay(
      slidingCurve: Curves.fastEaseInToSlowEaseOut,
      delay: Duration(milliseconds: 300),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            if (!Responsive.isDesktop(context))
              IconButton(
                icon: Icon(Icons.menu),
                onPressed: context.read<MenuAppController>().controlMenu,
              ),
            if (!Responsive.isMobile(context))
              Text(
                tabName,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            if (!Responsive.isMobile(context))
              Spacer(flex: Responsive.isDesktop(context) ? 1 : 1),
            Expanded(child: SearchField()),
            ProfileCard()
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      // color: Colors.transparent,
      splashRadius: 0,
      enableFeedback: false,
      child: Container(
        margin: EdgeInsets.only(left: AppPadding.p16),
        padding: EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p16 / 2,
        ),
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white10),
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              child: previewImage(
                photoRadius: 200,
                fileUser: UserModel.loadingUser().photoID,
                context: context,
              ),
            ),
            if (!Responsive.isMobile(context))
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: AppPadding.p16 / 2),
                child: Text("Admin User"),
              ),
            Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
      itemBuilder: (BuildContext bc) {
        return [
          PopupMenuItem(
            child: Text("Modify Profile"),
            onTap: () {
              TabsCubit.get(context).setTabScreen(Tabs.ProfileTab);
            },
          ),
          PopupMenuItem(
            child: Text("Logout"),
            onTap: () {
              TabsCubit.get(context).setTabScreen(Tabs.logoutTab);
            },
          ),
        ];
      },
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.secondaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
                child: Icon(
              Icons.av_timer,
            )),
            Container(
              padding: EdgeInsets.all(AppPadding.p16 * 0.75),
              margin: EdgeInsets.symmetric(horizontal: AppPadding.p16 / 2),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: ClockWidget(),
              // child: SvgPicture.asset("assets/icons/Search.svg"),
            ),
          ],
        ),
      ),
    );
  }
}
