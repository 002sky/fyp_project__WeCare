import 'package:flutter/material.dart';
import 'package:fyp_project_testing/modal/schedule.dart';
import 'package:fyp_project_testing/page/addSchudulePage.dart';
import 'package:fyp_project_testing/provider/auth.dart';
import 'package:fyp_project_testing/provider/scheduleProvider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ScheduleMainPage extends StatefulWidget {
  @override
  State<ScheduleMainPage> createState() => _ScheduleMainPageState();
}

class _ScheduleMainPageState extends State<ScheduleMainPage> {
  var _isInit = true;




  @override
  void didChangeDependencies() {
    if (_isInit) {

      String? id = Provider.of<Auth>(context, listen: false).userID;

      Provider.of<ScheduleProvider>(
        context,
        listen: false,
      ).getScheduleData(id!).then((_) {

      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: scheduleDataSource(_getScheduleData()),
        monthViewSettings: MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        showWeekNumber: true,
        weekNumberStyle: const WeekNumberStyle(
          backgroundColor: Colors.pink,
          textStyle: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
        onPressed: (() {
          Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => AddSchdeulePage(),
                fullscreenDialog: true,
              ));
        }),
      ),
    );
  }

  List<Schedule> _getScheduleData() {
    final List<Schedule> sc =
        Provider.of<ScheduleProvider>(context, listen: false).schedule;
    return sc;
  }
}

class scheduleDataSource extends CalendarDataSource {
  scheduleDataSource(List<Schedule> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getScheduleData(index).start_time;
  }

  @override
  DateTime getEndTime(int index) {
    return _getScheduleData(index).end_time;
  }

  @override
  String getSubject(int index) {
    return _getScheduleData(index).eventName;
  }


  Schedule _getScheduleData(int index) {
    final dynamic schedule = appointments![index];
    late final Schedule scheduleData;
    if (schedule is Schedule) {
      scheduleData = schedule;
    }

    return scheduleData;
  }
}
