import 'dart:math';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth.dart';

class AuthPage extends StatelessWidget {
  static const routename = '/auth';

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0x405ac18e),
              Color(0x995ac18e),
              Color(0xcc5ac18e),
              Color(0xff5ac18e),
            ],
          )),
        ),
        SingleChildScrollView(
          child: Container(
            height: deviceSize.height,
            width: deviceSize.width,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 94.0),
                      transform: Matrix4.rotationZ(-8 * pi / 180)
                        ..translate(-10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.greenAccent.shade700,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 8,
                              color: Colors.black26,
                              offset: Offset(0, 2))
                        ],
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: 50,
                          minHeight: 50,
                          maxWidth: 130,
                          maxHeight: 130,
                        ),
                        child: Image.asset(
                            'assets/image/WeCare-logos_black.png',
                            fit: BoxFit.scaleDown),
                      ),
                    ),
                  ),
                  Flexible(
                      flex: deviceSize.width > 600 ? 2 : 1, child: AuthForm()),
                ]),
          ),
        ),
      ]),
    );
  }
}

class AuthForm extends StatefulWidget {
  const AuthForm({Key? key}) : super(key: key);

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm>
    with SingleTickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String? email;
  String? password;

  var _isLoading = false;
  final _passwordController = TextEditingController();
  late AnimationController _controller;
  var remembermeValue;

  Future<void> _submit() async {
    _formKey.currentState?.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Auth>(context, listen: false).login(email!, password!);
    } catch (error) {
      print(error);
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: [
          TextFormField(
            validator: (value) {
              if (EmailValidator.validate(value!)) {
                email = value;
                return null;
              }
              return 'Plaue enter a valid email';
            },
            maxLines: 1,
            decoration: InputDecoration(
              hintText: 'Enter you email',
              prefixIcon: const Icon(Icons.email),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'please enter you password';
              }
              password= value;
              return null;
            },
            maxLines: 1,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Enter you password',
              prefixIcon: const Icon(Icons.lock),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Container(
              padding: EdgeInsets.symmetric(vertical: 25),
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 5,
                  primary: Colors.white,
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _submit();
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                      color: Color(0xff5ac18e),
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              )),
        ]));
  }
}






// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   bool _isLoading = false;
//   final _formkey = GlobalKey<FormState>();
//   var email;
//   var password;
//   var remembermeValue = false;
//   final _scaffoldKey = GlobalKey<ScaffoldState>();

//   _showMsg(msg) {
//     final snackBar = SnackBar(
//       content: Text(msg),
//       action: SnackBarAction(
//         label: 'Close',
//         onPressed: () {},
//       ),
//     );

//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       body: AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle.light,
//         child: GestureDetector(
//           child: Stack(
//             children: <Widget>[
//               Container(
//                   height: double.infinity,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                           begin: Alignment.topCenter,
//                           end: Alignment.bottomCenter,
//                           colors: [
//                         Color(0x405ac18e),
//                         Color(0x995ac18e),
//                         Color(0xcc5ac18e),
//                         Color(0xff5ac18e),
//                       ])),
//                   child: SingleChildScrollView(
//                     physics: AlwaysScrollableScrollPhysics(),
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 25,
//                       vertical: 120,
//                     ),
//                     child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           ConstrainedBox(
//                             constraints: BoxConstraints(
//                               minWidth: 50,
//                               minHeight: 50,
//                               maxWidth: 130,
//                               maxHeight: 130,
//                             ),
//                             child: Image.asset(
//                                 'assets/image/WeCare-logos_black.png',
//                                 fit: BoxFit.scaleDown),
//                           ),
//                           SizedBox(height: 50),
//                           Form(
//                             key: _formkey,
//                             child: Column(
//                               children: [
//                                 TextFormField(
                                  // validator: (value) {
                                  //   if (EmailValidator.validate(value!)) {
                                  //     email = value;
                                  //     return null;
                                  //   }
                                  //   return 'Plaue enter a valid email';
                                  // },
//                                   maxLines: 1,
//                                   decoration: InputDecoration(
//                                     hintText: 'Enter you email',
//                                     prefixIcon: const Icon(Icons.email),
//                                     border: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                     filled: true,
//                                     fillColor: Colors.white,
//                                   ),
//                                 ),
//                                 const SizedBox(height: 10),
//                                 TextFormField(
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return 'please enter you password';
//                                     }
//                                     password = value;
//                                     return null;
//                                   },
//                                   maxLines: 1,
//                                   obscureText: true,
//                                   decoration: InputDecoration(
//                                     hintText: 'Enter you password',
//                                     prefixIcon: const Icon(Icons.lock),
//                                     border: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10)),
//                                     filled: true,
//                                     fillColor: Colors.white,
//                                   ),
//                                 ),
//                                 CheckboxListTile(
//                                   title: const Text('Remember Me'),
//                                   contentPadding: EdgeInsets.zero,
//                                   value: remembermeValue,
//                                   activeColor:
//                                       Theme.of(context).colorScheme.primary,
//                                   onChanged: (newValue) {
//                                     setState(() {
//                                       remembermeValue = newValue!;
//                                     });
//                                   },
//                                   controlAffinity:
//                                       ListTileControlAffinity.leading,
//                                 ),
//                                 const SizedBox(height: 10),
//                                 Container(
//                                     padding: EdgeInsets.symmetric(vertical: 25),
//                                     width: double.infinity,
//                                     child: ElevatedButton(
//                                       style: ElevatedButton.styleFrom(
//                                         padding: EdgeInsets.all(15),
//                                         shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(15)),
//                                         elevation: 5,
//                                         primary: Colors.white,
//                                       ),
//                                       onPressed: () {
//                                         if (_formkey.currentState!.validate()) {
//                                           // _submit();
//                                         }
//                                       },
//                                       child: const Text(
//                                         'Login',
//                                         style: TextStyle(
//                                             color: Color(0xff5ac18e),
//                                             fontSize: 18,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     )),
//                               ],
//                             ),
//                           )
//                         ]),
//                   ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // void _login() async {
//   //   setState(() {
//   //     _isLoading = true;
//   //   });

//   //   var data = {
//   //     'email': email,
//   //     'password': password,
//   //   };

//   //   var res =  await Network().authData(data, '/login');
//   //   var body = json.decode(res.body);

//   //   if (body['success']) {
//   //     SharedPreferences localStorge = await SharedPreferences.getInstance();
//   //     localStorge.setString('token', json.encode('token'));
//   //     localStorge.setString('user', json.encode('user'));
//   //     Navigator.push(
//   //       context,
//   //       new MaterialPageRoute(
//   //         builder: (context) => MainPage(),
//   //       ),
//   //     );
//   //   } else {
//   //     _showMsg(body['message']);
//   //   }
//   // }


  
