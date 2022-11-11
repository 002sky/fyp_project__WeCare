import 'package:flutter/material.dart';
import 'package:fyp_project_testing/provider/medicationProvider.dart';
import 'package:fyp_project_testing/provider/scheduleProvider.dart';
import 'package:provider/provider.dart';

import '../provider/auth.dart';
import '../provider/profileProvider.dart';

import '../page/authPage.dart';
import '../page/mainPage.dart';
import '../page/splashPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(),
        ),
        ChangeNotifierProvider(
          create: ((context) => ScheduleProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => MedicationProvider()),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, auth, _) => MaterialApp(
          title: 'WeCare Management',
          theme: ThemeData(
              primaryColor: Color(0xff5ac18e),
              colorScheme: ColorScheme.light(
                primary: Color(0xff5ac18e),
                secondary: Color(0x405ac18e),
                
              ),
              toggleableActiveColor: Colors.orange,
              fontFamily: 'Lato',
              textTheme: ThemeData.light().textTheme.copyWith(
                      bodyText1: TextStyle(
                    color: Color.fromRGBO(20, 51, 51, 1),
                    fontSize: 16,
                  ))),
          home: auth.isAuth
              ? MainPage()
              : FutureBuilder(
                  builder: (context, authResultSnpshot) =>
                      authResultSnpshot.connectionState ==
                              ConnectionState.waiting
                          ? SplashPage()
                          : AuthPage(),
                ),
          routes: {},
        ),
      ),
    );
  }
}
