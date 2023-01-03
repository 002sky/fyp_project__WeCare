import 'package:flutter/material.dart';
import 'package:fyp_project_testing/component/NotificationFilter.dart';
import 'package:fyp_project_testing/component/notificationCard.dart';
import 'package:fyp_project_testing/provider/notificationProvider.dart';
import 'package:provider/provider.dart';

class NotidificationMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Notification',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              NotificationList(),
            ],
          )),
    );
  }
}

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
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
    // TODO: implement initState
    notificaitonData =
        Provider.of<notificationProvider>(context, listen: false).notification;
    print(notificaitonData);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<notificationProvider>(
        context,
        listen: false,
      ).getNotificationList().then((_) {
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
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Expanded(
            child: ListView.builder(
              itemCount: notificaitonData.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                    child: NotificationCard(
                      notificaitonData[index].taskName,
                      notificaitonData[index].time,
                    ));
              },
            ),
          );
  }

  
}
