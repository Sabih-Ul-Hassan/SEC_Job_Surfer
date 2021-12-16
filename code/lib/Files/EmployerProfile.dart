/// * Module Name : Employer Module
/// * Author : Sabih Ul Hassan
/// * Date Created : November 28,2021
/// * Modification History : None
/// * Synopsis :
///     -- This File contains a stateful widget's sub class,EmployerProfile, that acts as the
///        Employer profile Screen
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Classes/Employer.dart';
import '../CustomWidgets/JS_AppBar.dart';
import '../CustomWidgets/TwoValuesText.dart';

class EmployerProfile extends StatefulWidget {
  const EmployerProfile({Key? key}) : super(key: key);

  @override
  _EmployerProfileState createState() => _EmployerProfileState();
}

class _EmployerProfileState extends State<EmployerProfile> {
  Employer employer = Employer();

  @override
  Widget build(BuildContext context) {
    Map m1 =
        ModalRoute.of(context)?.settings.arguments as Map<String, Employer>;
    employer = m1["employer"];
    return Scaffold(
      appBar: JS_AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
                child: CircleAvatar(
                    radius: 100,
                    backgroundImage: AssetImage("assets/images/itachi.jpg"))),
            Center(
                child: Text(employer.userName, style: TextStyle(fontSize: 25))),
            Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Divider(
                  thickness: 3.0,
                )),
            Key1("Name", 20.0),
            Value(employer.Name, 20.0),
            Key1("CNIC", 20.0),
            Value(employer.CNIC, 20.0),
            Key1("Address", 20.0),
            Value(employer.Address, 20.0),
            Key1("date Of Birth", 20.0),
            Value(employer.DateOfBirth, 20.0),
            Key1("Contact Number", 20.0),
            Value(employer.ContactNumber, 20.0),
            Key1("Company Name", 20.0),
            Value(employer.CompanyName, 20.0),
          ],
        ),
      ),
    );
  }
}
