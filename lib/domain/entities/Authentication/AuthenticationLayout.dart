import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';

import '../../../config/utils/styles/app_colors.dart';
import '../../../data/local/inAppData.dart';
import '../../../presentation/Modules/Authentication/Login/LoginUser.dart';
import '../../../presentation/Shared/Components.dart';
import '../../../presentation/Shared/WidgetBuilders.dart';

class SignLayout extends StatefulWidget {
  @override
  State<SignLayout> createState() => _SignLayoutState();
}

class _SignLayoutState extends State<SignLayout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: AppColors.bgColor),
        child: Column(
          children: [
            buildHeader(),
            buildContactSection(),
          ],
        ),
      ),
    );
  }

  Widget buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        logoContainer(context),
        Text(
          "Welcome to TASKFORCE Admin Panel!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.white,
            fontSize: getWidth(2, context),
          ),
        )
      ],
    );
  }

  Widget buildContactSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildContactInfo(),
        buildSignSectionContainer(),
      ],
    );
  }

  Widget buildContactInfo() {
    return Container(
      width: getWidth(20, context),
      child: Column(
        children: [
          Text(
            "Facing any problems?",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.white,
              fontSize: getHeight(3, context),
            ),
          ),
          getCube(1, context),
          Text(
            "Contact support",
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: AppColors.white,
              fontSize: getHeight(2, context),
            ),
          ),
          Wrap(
            children: List.generate(
              socialMediaList.length,
              (index) => socialMediaItem(
                index: index,
                img: socialMediaList.keys.toList()[index],
                onTap: (index) {
                  openUrl(socialMediaList.values.toList()[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSignSectionContainer() {
    return Container(
      margin: EdgeInsets.all(20),
      height: getHeight(50, context),
      width: getWidth(50, context),
      child: DelayedDisplay(
        delay: Duration(milliseconds: 500),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.white,
          ),
          child: Login(),
        ),
      ),
    );
  }
}
