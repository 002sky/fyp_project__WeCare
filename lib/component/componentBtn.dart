import 'package:flutter/material.dart';

class ComponentBtn extends StatelessWidget {
  final String title;
  final IconData Icons;
  final Color color;


  ComponentBtn(this.Icons, this.color, this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      padding: const EdgeInsets.all(15),
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            IconButton(
              iconSize: 90,
              icon: Icon(Icons),
              tooltip: title,
              onPressed: () => print(title),
            ),
            Text(title),
          ],
        ),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          colors: [color.withOpacity(0.7), color],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }
}
