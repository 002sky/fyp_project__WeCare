import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';

final List<Meeting> meetings = <Meeting>[];

class ScheduleMainPage extends StatefulWidget {
  @override
  State<ScheduleMainPage> createState() => _ScheduleMainPageState();
}

class _ScheduleMainPageState extends State<ScheduleMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SfCalendar(
        view: CalendarView.month,
        dataSource: MeetingDataSource(meetings),
        monthViewSettings: MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (() {
          Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => FullScreenDialog(),
                fullscreenDialog: true,
              ));
        }),
      ),
    );
  }
}

class FullScreenDialog extends StatefulWidget {
  @override
  State<FullScreenDialog> createState() => _FullScreenDialog();
}

class _FullScreenDialog extends State<FullScreenDialog> {
  TextEditingController tileController = new TextEditingController();
  late DateTime startTime;
  late DateTime endTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff5ac18e),
        title: Text('Add Schedule'),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: FormBuilder(
          child: Column(
            children: [
              Align(
                child: Text('Add Schedule'),
                alignment: Alignment.center,
              ),
              SizedBox(height: 10),
              Align(
                child: Text('Schedule Title',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                alignment: Alignment.centerLeft,
              ),
              FormBuilderTextField(
                name: 'ScheduleTitle',
                controller: tileController,
              ),
              SizedBox(height: 10),
              Align(
                child: Text('Start Time',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                alignment: Alignment.centerLeft,
              ),
              FormBuilderDateTimePicker(
                name: 'StartTime',
                onChanged: (val) {

                  startTime = val!;
                },
              ),
              SizedBox(height: 10),
              Align(
                child: Text('End Time',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                alignment: Alignment.centerLeft,
              ),
              FormBuilderDateTimePicker(
                name: 'EndTime',
                onChanged: (val) {

                  endTime = val!;
                },
              ),
              SizedBox(height: 10),
              Align(
                child: Text('Color',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                alignment: Alignment.centerLeft,
              ),
              FormBuilderColorPickerField(
                name: 'Color',
                colorPickerType: ColorPickerType.materialPicker,
              ),
              Row(
                children: [
                  OutlinedButton(
                      onPressed: (() => _AddDataSource(
                          startTime, endTime, tileController.text)),
                      child: Text('button')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

List<Meeting> _AddDataSource(
    DateTime startTime, DateTime endTime, String title) {
  meetings
      .add(Meeting(title, startTime, endTime, const Color(0xFF0F8644), false));
  print(meetings.length);
  return meetings;
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);
  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}
