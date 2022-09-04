import 'package:flutter/material.dart';

class NotificationCard extends StatefulWidget {
  @override
  State<NotificationCard> createState() => _NotificationCard();
}

class _NotificationCard extends State<NotificationCard> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () => {},
        title: Text('Prepare Breakfirst'),
        trailing: Text('7.00AM'),
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.black54, width: 1),
        ),
        subtitle: Container(
          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: Column(
            children: [
              Row(
                children: [Text('testing')],
              ),
              Row(
                children: [
                  OutlinedButton(
                    onPressed: () => {},
                    child: Text('Daily'),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0)))),
                  ),
               
                ],
              )
            ],
          ),
        ));
  }
}
