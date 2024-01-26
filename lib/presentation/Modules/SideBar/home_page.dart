import 'package:admin/responsive.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/controllers/MenuAppController.dart';
import '../../Cubits/Tabs_cubit/tabs_cubit.dart';
import 'components/side_menu.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: context.read<MenuAppController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(),
              ),
            Expanded(
              flex: 5,
              child: BlocBuilder<TabsCubit, TabsState>(
                builder: (context, state) {
                  return DelayedDisplay(
                      slidingCurve: Curves.fastLinearToSlowEaseIn,
                      delay: Duration(milliseconds: 500),
                      child: TabsCubit.get(context).getTabScreen());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
