import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp_project_testing/page/mainPage.dart';
import 'package:fyp_project_testing/provider/userProvider.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class AddUserAccount extends StatefulWidget {
  const AddUserAccount({super.key});

  @override
  State<AddUserAccount> createState() => _AddUserAccountState();
}

class _AddUserAccountState extends State<AddUserAccount> {
  TextEditingController nameContoller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phonenumberContoller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String UserTypeSelected = 'Relative';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff5ac18e),
        title: Text('Create User Account Pages'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: <Widget>[
            nameTextField(),
            SizedBox(
              height: 10,
            ),
            EmailTextField(),
            SizedBox(
              height: 10,
            ),
            phoneNumberText(),
            SizedBox(
              height: 10,
            ),
            UserType(),
            SizedBox(
              height: 10,
            ),
            PasswordTextField(),
            SizedBox(
              height: 10,
            ),
            PasswordConfirmTextField(),
            SizedBox(
              height: 10,
            ),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  String data = jsonEncode({
                    'name': nameContoller.text,
                    'email': emailController.text,
                    'phone': phonenumberContoller.text,
                    'password': passwordController.text,
                    'status': UserTypeSelected,
                  });
                  Map<String, dynamic>? msg =
                      await Provider.of<UserProvider>(context, listen: false)
                          .setUserAccount(data);

                  if (msg!.isNotEmpty) {
                    _showErrorDialog(msg['message'].toString(),
                        msg['success'] != true ? 'Error' : 'Message');
                  }
                }
              },
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showErrorDialog(String msg, String title) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
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
                  if (title == 'Error') {
                    Navigator.of(context).pop();
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => MainPage(),
                        fullscreenDialog: true,
                      ),
                    );
                  }
                },
                child: Text('Confirm'))
          ],
        );
      },
    );
  }

  Widget nameTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Name Cannot be empty...';
        } else {
          return null;
        }
      },
      controller: nameContoller,
      decoration: InputDecoration(
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
            Icons.house,
            color: Theme.of(context).primaryColor,
          ),
          labelText: 'Name',
          helperText: 'Name Cannot Be Empty'),
    );
  }

  Widget EmailTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Email Cannot be empty...';
        } else {
          return null;
        }
      },
      controller: emailController,
      decoration: InputDecoration(
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
            Icons.house,
            color: Theme.of(context).primaryColor,
          ),
          labelText: 'Email',
          helperText: 'Email Cannot Be Empty'),
    );
  }

  Widget UserType() {
    String dropdownValue = 'Relative';
    return DropdownButtonFormField(
        items: <String>['Relative', 'Admin']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(fontSize: 18),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
            UserTypeSelected = newValue;
            print(UserTypeSelected);
          });
        },
        value: dropdownValue,
        decoration: InputDecoration(
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
            Icons.face,
            color: Theme.of(context).primaryColor,
          ),
        ));
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
      controller: passwordController,
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

  Widget PasswordConfirmTextField() {
    return TextFormField(
      validator: (value) {
        if (value!.isEmpty) {
          return 'Pleasea enter a your Password';
        } else if (value != passwordController.text) {
          return 'Password did Not Match';
        } else {
          return null;
        }
      },
      controller: passwordConfirmController,
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
          labelText: 'Password Confirm',
          helperText: 'Confirm  Password'),
    );
  }

  Widget phoneNumberText() {
    return IntlPhoneField(
      controller: phonenumberContoller,
      decoration: InputDecoration(
        labelText: 'Phone Number',
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
      ),
      initialCountryCode: 'MY',
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      disableLengthCheck: true,
      validator: (value) {
        if (value!.completeNumber.substring(1).isEmpty ||
            value.completeNumber.substring(1).length < 10 ||
            value.completeNumber.substring(1).length > 12) {
          return 'Phone number must greater than 10 digits and lesser than 12';
        }
        return null;
      },
    );
  }
}
