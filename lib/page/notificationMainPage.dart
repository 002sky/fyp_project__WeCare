import 'package:flutter/material.dart';
import 'package:fyp_project_testing/component/NotificationFilter.dart';
import 'package:fyp_project_testing/component/notificationCard.dart';
import 'package:fyp_project_testing/provider/notificationProvider.dart';
import 'package:provider/provider.dart';

import '../modal/notificationDaily.dart';


class NotidificationMainPage extends StatefulWidget {
  const NotidificationMainPage({super.key});

  @override
  State<NotidificationMainPage> createState() => _NotidificationMainPageState();
}

class _NotidificationMainPageState extends State<NotidificationMainPage> {

  var _isInit = true;
  var _isLoading = false;
  List<notificationDaily>   notificaitonData = [];

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

            notificaitonData =
        Provider.of<notificationProvider>(context, listen: false).notification;
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
    ;
  }

  
  Future<void> _handleRefresh() async {
      setState(() {
        _isLoading = true;
      });
      Provider.of<notificationProvider>(
        context,
        listen: false,
      ).getNotificationList().then((_) {

            notificaitonData =
        Provider.of<notificationProvider>(context, listen: false).notification;
        setState(() {
          _isLoading = false;
        });
      });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: ListView(
                     padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          children: [
            Text(
              'Notification',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            
            _isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: notificaitonData.length,
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.fromLTRB(0, 2, 0, 2),
                  child: NotificationCard(
                    notificaitonData[index].taskName,
                    notificaitonData[index].time,
                  ));
            },
          )
          ],
        ),
      ),
    );
  }
}



