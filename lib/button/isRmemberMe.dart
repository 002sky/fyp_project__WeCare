import 'package:flutter/material.dart';

class isRememberMeCb extends StatefulWidget {
  @override
  State<isRememberMeCb> createState() => _isRememberMeCb();
}

class _isRememberMeCb extends State<isRememberMeCb> {
  bool isRememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: isRememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  if (isRememberMe == false) {
                    isRememberMe = true;
                  } else {
                    isRememberMe = false;
                  }
                });
              },
            ),
          ),
          Text(
            'Remeber Me',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
