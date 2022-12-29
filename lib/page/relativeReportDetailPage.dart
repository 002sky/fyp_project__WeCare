import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../modal/report.dart';
import '../provider/statusReportProvider.dart';

class RelativeReportDetailPage extends StatefulWidget {
  String name;

  RelativeReportDetailPage(this.name, {super.key});

  @override
  State<RelativeReportDetailPage> createState() =>
      _RelativeReportDetailPageState();
}

class _RelativeReportDetailPageState extends State<RelativeReportDetailPage> {
  var _isInit = true;
  var _isLoading = false;
  List<Report> _report = [];
  // late String formattedDate;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<StatusReportProvider>(
        context,
        listen: false,
      ).getMedicationByID(widget.name).then((_) {
        _report = Provider.of<StatusReportProvider>(context, listen: false)
            .completeReportDetailByID;
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Status Report'),
      ),
      body: _isLoading == false
          ? ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              children: <Widget>[
                ContentDisplay('Written Time',
                    formatTime(_report.first.writtenTime.toString())),
                ContentDisplay('Eldery Name', _report.first.name.toString()),
                TextAreaDiaplay('Report', _report.first.report.toString())
              ],
            )
          : CircularProgressIndicator(),
    );
  }

  Widget ContentDisplay(String label, String data) {
    final display = TextEditingController();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: TextField(
        readOnly: true,
        controller: display..text = data,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal),
          ),
          labelText: label,
        ),
      ),
    );
  }

  Widget TextAreaDiaplay(String label, String data) {
    final display = TextEditingController();
    return TextFormField(
        maxLines: 15,
        maxLength: 400,
        controller: display..text = data,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).toggleableActiveColor,
              width: 2,
            ),
          ),
          labelText: 'Report',
        ));
  }

  String formatTime(String time) {
    DateTime date = DateTime.parse(_report.first.writtenTime);
    String formattedDate = DateFormat.yMMMd().format(date);

    return formattedDate;
  }
}
