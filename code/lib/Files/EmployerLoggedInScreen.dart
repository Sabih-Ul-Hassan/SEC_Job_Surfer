/// * Module Name : Employer Module
/// * Author : Sabih Ul Hassan
/// * Date Created : November 28,2021
/// * Modification History : None
/// * Synopsis :
///     -- This File contains a stateful widget's sub class, EmployerLoggedInScreen, that acts as the
///        logged in Screen screen for the employer
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
import 'package:sec/Variables.dart';
import '../CustomWidgets/JS_AppBar.dart';
import '../CustomWidgets/TextIconButton.dart';
import '../Classes/Employer.dart';
import '../Classes/JobAd.dart';

class EmployerLoggedInScreen extends StatefulWidget {
  const EmployerLoggedInScreen({Key? key}) : super(key: key);

  @override
  _EmployerLoggedInScreenState createState() => _EmployerLoggedInScreenState();
}

class _EmployerLoggedInScreenState extends State<EmployerLoggedInScreen> {
  //This method loads the data into, of employer, from the database.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  late Employer employer = Employer();

  @override
  Widget build(BuildContext context) {
    Map m = ModalRoute.of(context)!.settings.arguments as Map ;
    employer = m["employer"];
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
                      padding: EdgeInsets.fromLTRB(0, 50, 0, 0))),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 5, 2),
                    child: TextIconButtom(() {
                      Navigator.pushNamed(context, "/EmployerProfile",
                          arguments: {"employer": employer});
                    }, Icons.account_box_rounded, 90.0, colorThird_G, "Profile"),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 5, 2),
                    child: TextIconButtom(() async {
                      Navigator.pushNamed(context, "/JobAds",
                          arguments: {"employer": employer});
                    }, Icons.edit, 90.0, colorThird_G, "Job Ads"),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 5, 2),
                    child: TextIconButtom(() {
                      Navigator.pushNamed(context, "/SearchApplicant",
                          arguments: {"employer": employer});
                    }, Icons.search, 90.0, colorThird_G, "Applicants"),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(25, 0, 5, 2),
                    child: TextIconButtom(() {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Conformation"),
                                content:
                                    Text("Are you sure you want to log out?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.pushReplacementNamed(
                                            context, "/LoginPage");
                                      },
                                      child: Text(
                                        "Yes",
                                        style: TextStyle(color: colorThird_G),
                                      )),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        "No",
                                        style: TextStyle(color: colorThird_G),
                                      ))
                                ],
                              ));
                    }, Icons.login_outlined, 90.0, colorThird_G,
                        "Logout"),
                  ),
                ],
              )
            ],
          )));
    }
}

