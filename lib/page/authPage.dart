import 'dart:convert';
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
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.primary,
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

  var _isLoading = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  var remembermeValue;

  Future<void> _submit() async {
    _formKey.currentState?.save();
    setState(() {
      _isLoading = true;
    });
    try {
      final loginMessage = await Provider.of<Auth>(context, listen: false)
          .authentication(_emailController.text, _passwordController.text);

      if (loginMessage!.isNotEmpty) {
        Map<String, dynamic> jsonMessage = json.decode(loginMessage);

        _showErrorDialog(jsonMessage['message']);
      }
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
        child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            children: <Widget>[
              EmailTextField(),
              const SizedBox(height: 10),
              PasswordTextField(),
              const SizedBox(height: 10),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 25),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(15),
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

  Future<void> _showErrorDialog(String msg) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Confirm'))
          ],
        );
      },
    );
  }

  Widget EmailTextField() {
    return TextFormField(
      validator: (value) {
        if (EmailValidator.validate(value!)) {
          return null;
        } else if (value.isEmpty) {
          return 'Pleasea enter a email address';
        } else {
          return 'please enter a valid email addree';
        }
      },
      controller: _emailController,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).toggleableActiveColor,
              width: 2,
            ),
          ),
          prefixIcon: Icon(
            Icons.email,
            color: Theme.of(context).primaryColor,
          ),
          labelText: 'Email',
          helperText: 'Enter Your Email Address'),
    );
  }

  Widget PasswordTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Pleasea enter a  your Password';
        } else {
          return null;
        }
      },
      controller: _passwordController,
      obscureText: true,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.teal,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).toggleableActiveColor,
              width: 2,
            ),
          ),
          prefixIcon: Icon(
            Icons.password,
            color: Theme.of(context).primaryColor,
          ),
          labelText: 'Password',
          helperText: 'Enter Your Password'),
    );
  }
}

