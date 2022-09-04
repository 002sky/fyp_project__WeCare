import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/auth.dart';
import '../provider/ElderlyProfile.dart';

import '../page/authPage.dart';
import '../page/mainPage.dart';
import '../page/splashPage.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> Auth(),),
        ChangeNotifierProvider(create: (context) => Profile(),),
      ],

      child: Consumer<Auth>(
        builder: (context,auth,_)=> MaterialApp(
          title:  'WeCare Management',
          home: auth.isAuth
          ? MainPage()
          :FutureBuilder(builder: (context,authResultSnpshot)
            => authResultSnpshot.connectionState == ConnectionState.waiting? SplashPage():AuthPage(),
          ),
          routes: {},
         
        ),


      
      ),
    );
  }
}
