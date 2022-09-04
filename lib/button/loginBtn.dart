import 'package:flutter/material.dart';

import 'package:fyp_project_testing/page/mainPage.dart';

class LoginBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
     return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).pushNamed(MainPage.routeName),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          elevation: 5,
          primary: Colors.white,
        ),
        child: Text(
          'Login',
          style: TextStyle(
            color: Color(0xff5ac18e),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    
  }
  
}

