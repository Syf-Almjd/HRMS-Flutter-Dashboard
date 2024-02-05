import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockWidget extends StatelessWidget {
  const ClockWidget();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        return Text(
            "${DateTime.now().timeZoneName} ${DateFormat('hh:mm a, MM - dd - yyyy').format(DateTime.now())}");
      },
    );
  }
}
