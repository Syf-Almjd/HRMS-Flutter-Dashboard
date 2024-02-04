import 'package:admin/data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import 'package:admin/presentation/Cubits/navigation_cubit/navi_cubit.dart';
import 'package:admin/presentation/Shared/Components.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/Models/UserModel.dart';

class DeleteStaffScreen extends StatelessWidget {
  final UserModel userModel;

  const DeleteStaffScreen(this.userModel);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 200))
        .then((value) => showChoiceDialog(
            context: context,
            title: "Delete ${userModel.name}",
            onNo: () {
              NaviCubit.get(context).pop(context);
            },
            onYes: () {
              RemoteDataCubit.get(context)
                  .userDeleteData(userModel, context)
                  .then((value) => NaviCubit.get(context).pop(context));
            }));
    return Container(
      color: Colors.white,
    );
  }
}
