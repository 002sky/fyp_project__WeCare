import 'package:flutter/material.dart';

class NotificationFilter extends StatefulWidget {
  @override
  State<NotificationFilter> createState() => _NotificationFilter();
}

class _NotificationFilter extends State<NotificationFilter> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Row(
      
      children: [
        OutlinedButton(
          onPressed: () => {}, 
          child: Text('Daily'),
        ),

        OutlinedButton(
          onPressed: () => {},
          child: Text('Medication'),
        ),


        OutlinedButton(
          onPressed: () => {},
          child: Text('Appointment'),
        ),
      ],
    )
    );
  }
}
