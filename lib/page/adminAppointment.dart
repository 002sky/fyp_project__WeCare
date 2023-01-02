import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fyp_project_testing/provider/appointmentProvider.dart';
import 'package:provider/provider.dart';

import '../modal/appointment.dart';

class AdminAppointment extends StatefulWidget {
  const AdminAppointment({super.key});

  @override
  State<AdminAppointment> createState() => _AdminAppointmentState();
}

class _AdminAppointmentState extends State<AdminAppointment> {
  var _isInit = true;
  var _isLoading = false;
  List<Appointment> appointment = [];

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<AppointmentProvider>(
        context,
        listen: false,
      ).getAllAppointment().then((_) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Relative Visit Appointment'),
      ),
      body: _isLoading == false
          ? ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              itemCount: appointment.length,
              itemBuilder: (context, index) {
                return Slidable(
                  child: ListTile(
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(color: Colors.green, width: 2),
                    ),
                    title: Text(appointment[index].name.toString()),
                    subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Reson : ' +
                              appointment[index].reason.toString()),
                          Text('Date : ' + appointment[index].date.toString()),
                          Text('Time : ' + appointment[index].time.toString()),
                        ]),
                    trailing: Icon(Icons.arrow_left_outlined),
                  ),
                  endActionPane: ActionPane(
                    motion: ScrollMotion(),
                    children: <Widget>[
                      SlidableAction(
                        flex: 2,
                        onPressed: (context) async {
                          String profileData = jsonEncode({
                            'id': appointment[index].id,
                          });
                          Map<String, dynamic>? msg =
                              await Provider.of<AppointmentProvider>(context,
                                      listen: false)
                                  .approvalAppointment(profileData);

                          if (msg!.isNotEmpty) {
                            _showErrorDialog(msg['message'],
                                msg['success'] != true ? 'Error' : 'Message');
                          }
                        },
                        backgroundColor: Color(0xFF7BC043),
                        foregroundColor: Colors.white,
                        icon: Icons.approval,
                      ),
                      SlidableAction(
                        flex: 2,
                        onPressed: (context) async {
                          String data = jsonEncode({
                            'id': appointment[index].id,
                          });
                          Map<String, dynamic>? msg =
                              await Provider.of<AppointmentProvider>(context,
                                      listen: false)
                                  .disapprovalAppointment(data);

                          if (msg!.isNotEmpty) {
                            _showErrorDialog(msg['message'],
                                msg['success'] != true ? 'Error' : 'Message');
                          }
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                      ),
                    ],
                  ),
                );
              })
          : CircularProgressIndicator(),
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
                onPressed: () async {
                  Navigator.of(context).pop();

                  setState(() {
                    _isLoading = true;
                    _isInit = true;
                    didChangeDependencies();
                  });
                },
                child: Text('Confirm'))
          ],
        );
      },
    );
  }
}
