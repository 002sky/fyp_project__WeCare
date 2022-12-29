import 'package:flutter/material.dart';
import 'package:fyp_project_testing/modal/report.dart';
import 'package:fyp_project_testing/page/relativeReportDetailPage.dart';
import 'package:fyp_project_testing/provider/statusReportProvider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../provider/auth.dart';

class RelativeStatusRpeortPage extends StatefulWidget {
  const RelativeStatusRpeortPage({super.key});

  @override
  State<RelativeStatusRpeortPage> createState() =>
      _RelativeStatusRpeortPageState();
}

class _RelativeStatusRpeortPageState extends State<RelativeStatusRpeortPage> {
  var _isInit = true;
  var _isLoading = false;
  List<Report> ListReport = [];
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      int? userID = Provider.of<Auth>(context, listen: false).userID;

      Provider.of<StatusReportProvider>(
        context,
        listen: false,
      ).getStatusReportByID(userID!).then((_) {
        ListReport = Provider.of<StatusReportProvider>(context, listen: false)
            .completeReport;
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
      body: ListReport != []
          ? ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              shrinkWrap: true,
              itemCount: ListReport.length,
              itemBuilder: ((context, index) {
                DateTime date = DateTime.parse(ListReport[index].writtenTime);
                String formattedDate = DateFormat.yMMMd().format(date);
                return ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              RelativeReportDetailPage(ListReport[index].writtenTime),
                          fullscreenDialog: true,
                        ));
                  },
                  title: Text(ListReport[index].name),
                  subtitle: Text(formattedDate),
                  trailing: Icon(Icons.expand),
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(color: Colors.green, width: 2),
                  ),
                );
              }))
          : Container(),
    );
  }
}
