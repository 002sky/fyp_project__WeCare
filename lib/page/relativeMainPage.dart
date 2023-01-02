import 'package:flutter/material.dart';
import 'package:fyp_project_testing/page/addAppointmentPage.dart';
import 'package:fyp_project_testing/page/relativeStatusReportPage.dart';
import 'package:fyp_project_testing/provider/appointmentProvider.dart';
import 'package:provider/provider.dart';

import '../drawer/appDrawer.dart';
import '../modal/appointment.dart';
import '../provider/auth.dart';

class RelativeMainPage extends StatefulWidget {
  const RelativeMainPage({super.key});

  @override
  State<RelativeMainPage> createState() => _RelativeMainPageState();
}

class _RelativeMainPageState extends State<RelativeMainPage> {
  bool userType = true;
  var _isInit = true;
  var _isLoading = false;
  List<Appointment> appointment = [];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      int? id = Provider.of<Auth>(context, listen: false).userID;

      Provider.of<AppointmentProvider>(
        context,
        listen: false,
      ).getAppointment(id).then((_) {
        appointment = Provider.of<AppointmentProvider>(context, listen: false)
            .appointmentList;

        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _handleRefresh() async {
    int? id = Provider.of<Auth>(context, listen: false).userID;

    Provider.of<AppointmentProvider>(
      context,
      listen: false,
    ).getAppointment(id).then((_) {
      appointment = Provider.of<AppointmentProvider>(context, listen: false)
          .appointmentList;

      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('WeCare'),
        ),
        drawer: AppDrawer(),
        body: RefreshIndicator(
          onRefresh: _handleRefresh,
          child: ListView(
            children: [
              GridView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                ),
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              AddAppointmentPage(),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.green,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.schedule,
                                size: 48,
                                color: Colors.greenAccent,
                              ),
                              Text(
                                'Appointment',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) =>
                              RelativeStatusRpeortPage(),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.green,
                        width: 2,
                      )),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.document_scanner,
                              size: 48,
                              color: Colors.greenAccent,
                            ),
                            Text(
                              'Status Report',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              appointment.isNotEmpty
                  ? ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      shrinkWrap: true,
                      itemCount: appointment.length,
                      itemBuilder: ((context, index) {
                        return ListTile(
                          title: Text("Appointment :" +
                              appointment[index].date.toString()),
                          subtitle: Text('Time :' + appointment[index].time),
                          tileColor: appointment[index].status == null
                              ? Colors.white
                              : appointment[index].status == true
                                  ? Colors.blue
                                  : Colors.red,
                          shape: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            borderSide:
                                BorderSide(color: Colors.green, width: 2),
                          ),
                        );
                      }))
                  : Container(),
            ],
          ),
        ));
  }
}
