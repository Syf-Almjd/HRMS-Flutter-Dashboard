import 'package:admin/presentation/Cubits/Tabs_cubit/tabs_cubit.dart';
import 'package:admin/responsive.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../config/utils/managers/app_values.dart';
import '../../../../../config/utils/styles/app_colors.dart';
import '../../../../../domain/controllers/MenuAppController.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
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
                "Dashboard",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            if (!Responsive.isMobile(context))
              Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
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
            Image.asset(
              "assets/images/profilePicture.jpg",
              height: 38,
              fit: BoxFit.contain,
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
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: AppColors.secondaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(AppPadding.p16 * 0.75),
            margin: EdgeInsets.symmetric(horizontal: AppPadding.p16 / 2),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
