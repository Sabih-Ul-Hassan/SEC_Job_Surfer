/// * Module Name : Employer Module
/// * Author : Sabih Ul Hassan
/// * Date Created : November 28,2021
/// * Modification History : None
/// * Synopsis :
///     -- This File contains a stateful widget's sub class, LoginPage, that acts as the
///       log in Screen
/// * Authorization : Everyone
/// * Coding Standards :
///     -- Class variables should start with a capital alphabet
///     -- Methods, functions, and local variables should be written
///        in cemal case
///     -- Functions that return a widget should start with an uppercase alphabet
///     -- Methods and functions should not hav more then 10 statements
///     -- Function or methods, that return a widget, should not be limited
///        in terms of number of lines, and start with a upper case alphabet
///     -- Global variables should end with _G


import 'package:flutter/material.dart';
import 'package:sec/Classes/MySQL.dart';
import 'package:sec/Classes/User.dart';
import 'package:sec/Variables.dart';
import '../CustomWidgets/JS_AppBar.dart';
import '../CustomWidgets/txtfeilds.dart';
import '../Variables.dart';
import '../Classes/Employer.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> login(userName,password,context) async {
    Navigator.pushNamed(context, "/Spinner");
    if (!MySQL.Connected)
      await MySQL.getConnection(context);

      if (UserName.text.length<1|| UserName.text.contains(" ")|| Password.text.length<1 || !(await employer.login(userName, password, context)))
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Login Failed"),
              content: Text("Invalid username, or password"),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text("Okay"))
              ],
            ));
      else {
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, "/EmployerLoggedInScreen", arguments: {"employer":employer});}
    }
  Employer employer = Employer();
  TextEditingController UserName = TextEditingController();
  TextEditingController Password = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: JS_AppBar(),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Center(
                child: Container(
                    child: Image(
                      image: AssetImage('assets/images/logo.png'),
                      height: 270,
                      width: 270,
                    ),
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0))),
            Container(
              child: Text("User Name *"),
              padding: EdgeInsets.fromLTRB(
                20.0,
                0.0,
                260.0,
                0.0,
              ),
            ),
            Container(
                child: JsTextFeildIconed(
                    "For example, User_name123",
                    UserName,
                    Icon(Icons.person),
                    20.0,
                    10.0,
                    10.0,
                    0.0,
                    "Spaces are not allowed")),
            Container(
              child: Text("Password *"),
              padding: EdgeInsets.fromLTRB(
                20.0,
                20.0,
                260.0,
                0.0,
              ),
            ),
            Container(
                child: JsTextFeildIconed("Password", Password, Icon(Icons.lock),
                    20.0, 10.0, 10.0, 15.0, "", true)),
            FlatButton(
                color: colorThird_G,
                 onPressed: ()async { await login(UserName.text,Password.text,context); },
                 child: Text("Login"))
          ],
        )));
  }
}
