import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../modal/dailySchedule.dart';
import '../provider/notificationProvider.dart';

class ScheduleDetailView extends StatefulWidget {
  String taskname;
  String time;

  ScheduleDetailView(this.taskname, this.time, {super.key});

  @override
  State<ScheduleDetailView> createState() => _ScheduleDetailViewState();
}

class _ScheduleDetailViewState extends State<ScheduleDetailView> {
  var _isInit = true;
  var _isLoading = false;
  late final notificaitonData;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    String data = jsonEncode({
      'taskName': widget.taskname,
      'time': widget.time,
    });
    // TODO: implement initState

    super.initState();
  }

  @override
  void didChangeDependencies() {
    String data = jsonEncode({
      'taskName': widget.taskname,
      'time': widget.time,
    });

    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<notificationProvider>(
        context,
        listen: false,
      ).getScheduleDetail(data).then((_) {
        notificaitonData =
            Provider.of<notificationProvider>(context, listen: false)
                .scheduleDetail;
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
    ;
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading == true
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xff5ac18e),
              title: Text('Medication Detail'),
            ),
            body: Container(
                child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    notificaitonData[0].time,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: notificaitonData.length,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                          child: DetailCard(
                            notificaitonData[index].elderlyName,
                            notificaitonData[index].detail,
                          ));
                    },
                  ),
                ),
              ],
            )),
          );
  }

  Widget DetailCard(String name, List<DailyScheduleDetail> detail) {
    return ExpansionTile(
      title: Text(name),
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: detail.length,
            itemBuilder: (context, index) {
              return Slidable(
                child: ListTile(
                  tileColor: detail[index].status == true
                      ? Colors.green
                      : Colors.redAccent,
                  title: Text(detail[index].medicationName.toString()),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(detail[index].type.toString())]),
                  trailing: Icon(Icons.arrow_left_outlined),
                ),
                endActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: <Widget>[
                    SlidableAction(
                      flex: 2,
                      onPressed: (context) async {
                        String profileData = jsonEncode({
                          'id': detail[index].id,
                        });
                        Map<String, dynamic>? msg =
                            await Provider.of<notificationProvider>(context,
                                    listen: false)
                                .updateDailySchedule(profileData);

                        if (msg.isNotEmpty) {
                          _showErrorDialog(msg['message'],
                              msg['success'] != true ? 'Error' : 'Message');
                        }
                      },
                      backgroundColor: Color(0xFF7BC043),
                      foregroundColor: Colors.white,
                      icon: Icons.archive,
                      label: 'Complete',
                    ),
                  ],
                ),
              );
            })
      ],
    );
  }

  Future<void> _showErrorDialog(String msg, String title) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => this.widget));
                },
                child: Text('Confirm'))
          ],
        );
      },
    );
  }
}
