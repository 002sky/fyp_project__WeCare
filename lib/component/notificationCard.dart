import 'package:flutter/material.dart';
import 'package:fyp_project_testing/page/scheduleDetailView.dart';
import 'package:intl/intl.dart';

class NotificationCard extends StatelessWidget {
  final String taskName;
  final String time;

  NotificationCard(this.taskName, this.time);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => {

         Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => ScheduleDetailView(this.taskName,this.time),
                  fullscreenDialog: true,
                ),)
      },
      title: Text(taskName),
      trailing: Text(stringToTimeOfDay(time).format(context)),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.black54, width: 1),
      ),
    );
  }

  TimeOfDay stringToTimeOfDay(String tod) {
    TimeOfDay _startTime = TimeOfDay(
        hour: int.parse(tod.split(":")[0]),
        minute: int.parse(tod.split(":")[1]));

    return _startTime;
  }
}
