import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

        
    notificaitonData = Provider.of<notificationProvider>(context, listen: false)
        .scheduleDetail;
    print(notificaitonData);
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
        : Container(child: Text(notificaitonData.first.elderlyName));
  }
}
