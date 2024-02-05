import 'package:admin/data/remote/RemoteData_cubit/RemoteData_cubit.dart';
import 'package:admin/presentation/Cubits/navigation_cubit/navi_cubit.dart';
import 'package:admin/presentation/Shared/Components.dart';
import 'package:admin/presentation/Shared/WidgetBuilders.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../config/utils/styles/app_colors.dart';

class KeyStaffScreen extends StatefulWidget {
  KeyStaffScreen({Key? key}) : super(key: key);

  @override
  _KeyStaffScreenState createState() => _KeyStaffScreenState();
}

class _KeyStaffScreenState extends State<KeyStaffScreen> {
  TextEditingController keyInput = TextEditingController(text: "Loading");
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    keyInput.text =
        await RemoteDataCubit.get(context).getRegistrationKey(context);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Registration Key'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Container(
          width: getWidth(30, context),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: keyInput,
                decoration: InputDecoration(labelText: "User Register Key"),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Clipboard.setData(new ClipboardData(text: keyInput.text));
                      showToast("Key Copied!", AppColors.primaryColor, context);
                    },
                    child: Text('Copy'),
                  ),
                  loadButton(
                    buttonWidth: getWidth(13, context),
                    textSize: 13,
                    onPressed: () {
                      onSubmitted();
                    },
                    buttonText: 'Update',
                  ),
                  TextButton(
                    onPressed: () {
                      NaviCubit.get(context).pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  onSubmitted() {
    if (keyInput.text.isNotEmpty) {
      RemoteDataCubit.get(context)
          .updateRegistrationKey(keyInput, context)
          .then((value) => NaviCubit.get(context).pop(context));
    } else {
      showToast("Please fill in all details", AppColors.primaryColor, context);
    }
  }
}
